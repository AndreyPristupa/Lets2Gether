json.array!(@articles) do |article|
  json.extract! article, :id, :user_id, :category_id, :name, :description, :status_id, :group_id
  json.url article_url(article, format: :json)
end
