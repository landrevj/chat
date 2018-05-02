json.root_posts do
    json.array!(@root_posts) do |r|
        json.id r.id
        json.subject r.subject
        json.body r.body
        json.url board_root_post_path(r.board, r)
    end
end

json.child_posts do
    json.array!(@child_posts) do |c|
        json.id c.id
        json.body c.body
        json.url child_post_path(c)
    end
end
