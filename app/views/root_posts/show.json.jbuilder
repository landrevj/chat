# json.partial! "root_posts/root_post", root_post: @root_post
json.root_post @root_post
json.html render partial: 'root_posts/root_post_full.html.erb', locals: {board: @root_post.board, root_post: @root_post}
