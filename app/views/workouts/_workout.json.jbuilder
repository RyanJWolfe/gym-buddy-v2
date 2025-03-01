json.extract! workout, :id, :user_id, :workout_date, :notes, :created_at, :updated_at
json.url workout_url(workout, format: :json)
