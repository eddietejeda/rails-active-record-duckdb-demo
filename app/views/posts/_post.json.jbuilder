json.extract! post, :id, :user_id, :title, :content, :status, :view_count, :rating, :published_at, :created_at, :updated_at
json.url post_url(post, format: :json)
