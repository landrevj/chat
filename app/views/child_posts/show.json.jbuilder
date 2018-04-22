# json.partial! "child_posts/child_post", child_post: @child_post
json.child_post @child_post
json.html render partial: 'child_posts/child_post.html.erb', locals: {child_post: @child_post}
