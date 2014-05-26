json.array!(@commons) do |common|
  json.extract! common, :id
  json.url common_url(common, format: :json)
end
