json.extract! child_post, :id, :body, :picture, :root_post_id, :created_at, :updated_at
json.url child_post_url(child_post, format: :json)
