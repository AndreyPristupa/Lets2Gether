json.array!(@users) do |user|
  json.extract! user, :id, :name, :first_name, :last_name, :phone, :image, :email, :status, :group
  json.url user_url(user, format: :json)
end
