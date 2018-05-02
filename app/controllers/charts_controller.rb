class ChartsController < ApplicationController
    def posts
        render json: {"Total Live Threads": RootPost.all.count, "Total Live Posts": ChildPost.all.count}
    end
    def posts_by_hour
        render json: [{name: 'Threads', data: RootPost.group_by_minute(:created_at).count},
            {name: 'Posts', data: ChildPost.group_by_minute(:created_at).count}]
        end
    def messages
        render json: Message.group_by_hour(:created_at).count
    end
    def rooms
        render json: Room.all.map { |r| {"#{r.name}": r.messages.count}}.reduce(:merge)
    end
end
