# json.partial! "root_posts/root_post", root_post: @root_post
json.root_post do
    json.data @root_post
    json.html render partial: 'root_posts/root_post_full.html.erb', locals: {board: @root_post.board, root_post: @root_post}
end

json.child_posts @child_posts do |child_post|
    json.data child_post
    json.html render partial: 'child_posts/child_post.html.erb', locals: {child_post: child_post}
end
