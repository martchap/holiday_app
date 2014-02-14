json.array!(@holidays) do |holiday|
  json.extract! holiday, :user_id, :start_date, :end_date
  json.url holiday_url(holiday, format: :json)
end