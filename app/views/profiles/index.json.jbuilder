json.array!(@profiles) do |profile|
  json.extract! profile, :id, :index
  json.url profile_url(profile, format: :json)
end
