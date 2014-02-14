json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :start_date, :end_date
  json.url user_url(user, format: :json)
end
