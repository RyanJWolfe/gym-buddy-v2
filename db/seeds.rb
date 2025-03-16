# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create exercise categories
categories = ["Legs", "Push", "Pull", "Core", "Cardio", "Full Body"]
equipment_types = ["Barbell", "Dumbbell", "Machine", "Cable", "Bodyweight", "Kettlebell", "Resistance Band"]

# Create common exercises
exercises = [
  { name: "Squat", category: "Legs", equipment_type: "Barbell", description: "A compound exercise that works the quadriceps, hamstrings, and glutes." },
  { name: "Deadlift", category: "Pull", equipment_type: "Barbell", description: "A compound exercise that works the back, glutes, and hamstrings." },
  { name: "Bench Press", category: "Push", equipment_type: "Barbell", description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Overhead Press", category: "Push", equipment_type: "Barbell", description: "A compound exercise that works the shoulders and triceps." },
  { name: "Pull-up", category: "Pull", equipment_type: "Bodyweight", description: "A compound exercise that works the back and biceps." },
  { name: "Leg Press", category: "Legs", equipment_type: "Machine", description: "An exercise that primarily works the quadriceps, hamstrings, and glutes." },
  { name: "Lat Pulldown", category: "Pull", equipment_type: "Cable", description: "An exercise that works the back and biceps." },
  { name: "Dumbbell Row", category: "Pull", equipment_type: "Dumbbell", description: "An exercise that works the back and biceps." },
  { name: "Leg Extension", category: "Legs", equipment_type: "Machine", description: "An isolation exercise that works the quadriceps." },
  { name: "Leg Curl", category: "Legs", equipment_type: "Machine", description: "An isolation exercise that works the hamstrings." },
  { name: "Dumbbell Bench Press", category: "Push", equipment_type: "Dumbbell", description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Tricep Pushdown", category: "Push", equipment_type: "Cable", description: "An isolation exercise that works the triceps." },
  { name: "Bicep Curl", category: "Pull", equipment_type: "Dumbbell", description: "An isolation exercise that works the biceps." },
  { name: "Plank", category: "Core", equipment_type: "Bodyweight", description: "An isometric exercise that works the core muscles." },
  { name: "Russian Twist", category: "Core", equipment_type: "Bodyweight", description: "An exercise that works the obliques and abdominals." },
  { name: "Crunches", category: "Core", equipment_type: "Bodyweight", description: "An exercise that works the abdominals." },
  { name: "Lunges", category: "Legs", equipment_type: "Bodyweight", description: "A compound exercise that works the quadriceps, hamstrings, and glutes." },
  { name: "Shoulder Press", category: "Push", equipment_type: "Dumbbell", description: "A compound exercise that works the shoulders and triceps." },
  { name: "Face Pull", category: "Pull", equipment_type: "Cable", description: "An exercise that works the rear deltoids and upper back." },
  { name: "Kettlebell Swing", category: "Full Body", equipment_type: "Kettlebell", description: "A dynamic exercise that works the posterior chain and cardiovascular system." }
]

puts "Creating exercises..."
exercises.each do |exercise_data|
  Exercise.find_or_create_by!(name: exercise_data[:name]) do |exercise|
    exercise.category = exercise_data[:category]
    exercise.equipment_type = exercise_data[:equipment_type]
    exercise.description = exercise_data[:description]
  end
end

puts "Created #{Exercise.count} exercises"

# Create a demo user if none exists
if Rails.env.development? && User.count.zero?
  puts "Creating demo user..."
  user = User.create!(
    email: "demo@example.com",
    password: "password",
    password_confirmation: "password"
  )

  # Create some sample workouts
  puts "Creating sample workouts..."

  # Push workout
  push_workout = user.workouts.create!(
    name: "Push Day",
    date: 2.days.ago.to_date,
    start_time: 2.days.ago.beginning_of_day + 17.hours,
    end_time: 2.days.ago.beginning_of_day + 18.hours + 30.minutes,
    notes: "Felt strong today. Increased bench press weight."
  )

  # Add exercises to push workout
  bench_press = Exercise.find_by(name: "Bench Press")
  bench_log = push_workout.exercise_logs.create!(
    exercise: bench_press,
    notes: "Focused on form and controlled descent"
  )

  # Add sets to bench press
  [
    { set_number: 1, weight: 60, reps: 10, rest_seconds: 90 },
    { set_number: 2, weight: 70, reps: 8, rest_seconds: 120 },
    { set_number: 3, weight: 80, reps: 6, rest_seconds: 120 },
    { set_number: 4, weight: 80, reps: 5, rest_seconds: 120 }
  ].each do |set_data|
    bench_log.sets.create!(set_data)
  end

  # Add overhead press
  overhead_press = Exercise.find_by(name: "Overhead Press")
  overhead_log = push_workout.exercise_logs.create!(
    exercise: overhead_press,
    notes: "Shoulders felt a bit tight"
  )

  # Add sets to overhead press
  [
    { set_number: 1, weight: 40, reps: 10, rest_seconds: 90 },
    { set_number: 2, weight: 45, reps: 8, rest_seconds: 90 },
    { set_number: 3, weight: 45, reps: 7, rest_seconds: 90 }
  ].each do |set_data|
    overhead_log.sets.create!(set_data)
  end

  # Pull workout
  pull_workout = user.workouts.create!(
    name: "Pull Day",
    date: 1.day.ago.to_date,
    start_time: 1.day.ago.beginning_of_day + 18.hours,
    end_time: 1.day.ago.beginning_of_day + 19.hours + 15.minutes,
    notes: "Great back pump today."
  )

  # Add deadlift
  deadlift = Exercise.find_by(name: "Deadlift")
  deadlift_log = pull_workout.exercise_logs.create!(
    exercise: deadlift,
    notes: "Used mixed grip for heavy sets"
  )

  # Add sets to deadlift
  [
    { set_number: 1, weight: 100, reps: 8, rest_seconds: 120 },
    { set_number: 2, weight: 120, reps: 6, rest_seconds: 150 },
    { set_number: 3, weight: 130, reps: 4, rest_seconds: 180 }
  ].each do |set_data|
    deadlift_log.sets.create!(set_data)
  end

  # Add pull-ups
  pullup = Exercise.find_by(name: "Pull-up")
  pullup_log = pull_workout.exercise_logs.create!(
    exercise: pullup,
    notes: "Used neutral grip"
  )

  # Add sets to pull-ups (bodyweight)
  [
    { set_number: 1, weight: 0, reps: 10, rest_seconds: 90 },
    { set_number: 2, weight: 0, reps: 8, rest_seconds: 90 },
    { set_number: 3, weight: 0, reps: 7, rest_seconds: 90 }
  ].each do |set_data|
    pullup_log.sets.create!(set_data)
  end

  # Leg workout
  leg_workout = user.workouts.create!(
    name: "Leg Day",
    date: Date.today,
    start_time: Date.today.beginning_of_day + 16.hours + 30.minutes,
    end_time: Date.today.beginning_of_day + 18.hours,
    notes: "Legs are going to be sore tomorrow!"
  )

  # Add squats
  squat = Exercise.find_by(name: "Squat")
  squat_log = leg_workout.exercise_logs.create!(
    exercise: squat,
    notes: "Focused on depth and keeping chest up"
  )

  # Add sets to squats
  [
    { set_number: 1, weight: 80, reps: 10, rest_seconds: 120 },
    { set_number: 2, weight: 100, reps: 8, rest_seconds: 150 },
    { set_number: 3, weight: 110, reps: 6, rest_seconds: 180 },
    { set_number: 4, weight: 110, reps: 5, rest_seconds: 180 }
  ].each do |set_data|
    squat_log.sets.create!(set_data)
  end

  # Add leg press
  leg_press = Exercise.find_by(name: "Leg Press")
  leg_press_log = leg_workout.exercise_logs.create!(
    exercise: leg_press,
    equipment_brand: "Hammer Strength",
    notes: "Feet high on platform to target glutes more"
  )

  # Add sets to leg press
  [
    { set_number: 1, weight: 150, reps: 12, rest_seconds: 90 },
    { set_number: 2, weight: 180, reps: 10, rest_seconds: 120 },
    { set_number: 3, weight: 200, reps: 8, rest_seconds: 120 },
    { set_number: 4, weight: 220, reps: 6, rest_seconds: 120 }
  ].each do |set_data|
    leg_press_log.sets.create!(set_data)
  end

  puts "Created #{user.workouts.count} sample workouts with exercises and sets"
end

puts "Seed completed successfully!"
