json.extract! user, :id, :name, :email, :age, :active, :bio, :created_at, :updated_at
json.url user_url(user, format: :json)
