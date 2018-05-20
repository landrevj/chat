class ChartsController < ApplicationController
  def posts
    render json: Board.all.map { |b| { name: b.abbreviation, data: { 'Threads' => b.root_posts.count, 'Posts' => ChildPost.joins(:root_post).where(root_posts: { board_id: b.id }).count } } }
  end

  def posts_by_hour
    render json: [{ name: 'Root', data: RootPost.group_by_day(:created_at, range: 5.week.ago.midnight..Time.now).count },
                  { name: 'Child', data: ChildPost.group_by_day(:created_at, range: 5.week.ago.midnight..Time.now).count }]
  end

  def messages
    render json: Message.group_by_day(:created_at, range: 5.week.ago.midnight..Time.now).count
  end

  def rooms
    render json: Room.all.map { |r| { "#{r.name}" => r.messages.count } }.reduce(:merge)
  end
end
