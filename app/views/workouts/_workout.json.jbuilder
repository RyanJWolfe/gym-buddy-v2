json.extract! workout, :id, :user_id, :workout_type_id, :date, :duration, :created_at, :updated_at
json.url workout_url(workout, format: :json)
