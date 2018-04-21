# json.partial! "root_posts/root_post", root_post: @root_post
json.root_post @root_post
json.user_name (@root_post.user.anonymous ? 'Anonymous' : @root_post.user.user_name)
json.markdown_body markdown(@root_post.body)
json.created_ago time_ago_in_words(@root_post.created_at)
json.updated_ago time_ago_in_words(@root_post.updated_at)

json.child_posts @child_posts
