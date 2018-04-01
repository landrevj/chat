json.extract! root_post, :id, :subject, :body, :picture, :created_at, :updated_at
json.url root_post_url(root_post, format: :json)
