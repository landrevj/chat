# json.partial! "root_posts/root_post", root_post: @root_post
json.root_post do
    json.data @root_post
    json.stats do
        json.posts 1 + @child_posts.count
        json.files @root_post.file_count
        json.users (@child_posts.where(user_id: @root_post.user.id).exists? ? 0 : 1) + @child_posts.distinct.count(:user_id)
    end
    json.html render partial: 'root_posts/root_post_full.html.erb', locals: { board: @root_post.board, root_post: @root_post }
end

json.child_posts @child_posts do |child_post|
    json.data child_post
    json.html render partial: 'child_posts/child_post.html.erb', locals: {child_post: child_post}
end
