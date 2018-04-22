# json.partial! "child_posts/child_post", child_post: @child_post
json.child_post @child_post
json.user_name (@child_post.user.anonymous ? 'Anonymous' : @child_post.user.user_name)
json.markdown_body markdown(@child_post.body)
json.replies_html replies(@child_post) if @child_post.root_reply_ids.any? || @child_post.child_reply_ids.any?
json.created_ago time_ago_in_words(@child_post.created_at)
json.updated_ago time_ago_in_words(@child_post.updated_at)
