json.array!(@payments) do |payment|
  json.extract! payment, :id, :user_id, :project_id, :payment_system_id, :amount, :currency, :status_id
  json.url payment_url(payment, format: :json)
end
