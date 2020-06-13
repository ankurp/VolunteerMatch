json.extract! post, :id, :content, :organization_id, :created_at, :updated_at
json.url post_url(post, format: :json)
