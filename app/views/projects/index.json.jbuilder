json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :user_id, :start_at, :end_at, :cost, :image, :video, :views, :is_enabled, :status
  json.url project_url(project, format: :json)
end
