json.extract! exercise_set, :id, :reps, :weight, :distance, :duration, :exercise_id, :created_at, :updated_at
json.url exercise_set_url(exercise_set, format: :json)
