json.array!(@stories) do |story|
  json.extract! story, :id, :user_id, :project_id, :name, :image, :description, :status, :is_enabled
  json.url story_url(story, format: :json)
end
