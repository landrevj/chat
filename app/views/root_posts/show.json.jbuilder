# json.partial! "root_posts/root_post", root_post: @root_post
json.root_post @root_post
json.user_name (@root_post.user.anonymous ? 'Anonymous' : @root_post.user.user_name)
json.markdown_body markdown(@root_post.body)
json.replies_html replies(@root_post) if @root_post.root_reply_ids.any? || @root_post.child_reply_ids.any?
json.created_ago time_ago_in_words(@root_post.created_at)
json.updated_ago time_ago_in_words(@root_post.updated_at)

json.child_posts @child_posts
