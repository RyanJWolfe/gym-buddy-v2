# Demo seeds for the demo user
# This file is intended to be loaded from db/seeds.rb and should only run in development

if Rails.env.development?
  # Read demo credentials from environment with safe defaults for local development.
  # You can customize these by setting DEMO_EMAIL and DEMO_PASSWORD in your shell.
  DEMO_EMAIL = ENV.fetch('DEMO_EMAIL', 'demo@example.com')
  DEMO_PASSWORD = ENV.fetch('DEMO_PASSWORD', 'password')

  if ENV['DEMO_EMAIL'].present? || ENV['DEMO_PASSWORD'].present?
    puts "Loading demo seed with ENV credentials (DEMO_EMAIL=#{DEMO_EMAIL.inspect})"
  else
    puts "Loading demo seed with default credentials (DEMO_EMAIL=#{DEMO_EMAIL.inspect}). To customize, set DEMO_EMAIL and DEMO_PASSWORD in your environment."
  end

  puts "Finding or creating demo user..."
  user = User.find_or_initialize_by(email: DEMO_EMAIL)
  if user.new_record?
    user.password = DEMO_PASSWORD
    user.password_confirmation = DEMO_PASSWORD
    user.save!
    puts "Created demo user #{DEMO_EMAIL}"
  else
    # Ensure local/dev account has a usable password (harmless for local development)
    if user.respond_to?(:encrypted_password) && user.encrypted_password.blank?
      user.password = DEMO_PASSWORD
      user.password_confirmation = DEMO_PASSWORD
      user.save!
    end
    puts "Found demo user #{DEMO_EMAIL}"
  end

  # Helper to add an exercise with sets to a workout
  def add_exercise_with_sets(workout, exercise_name, notes: nil, equipment_brand: nil, sets: [])
    exercise = Exercise.find_by!(name: exercise_name)
    log = workout.exercise_logs.create!(exercise: exercise, notes: notes, equipment_brand: equipment_brand)
    sets.each { |s| log.sets.create!(s) }
  end

  ActiveRecord::Base.transaction do
    # Remove prior demo workout data for this user (clean rebuild)
    workout_ids = user.workouts.pluck(:id)
    unless workout_ids.empty?
      exercise_log_ids = ExerciseLog.where(workout_id: workout_ids).pluck(:id)
      ExerciseSet.where(exercise_log_id: exercise_log_ids).delete_all if exercise_log_ids.any?
      ExerciseLog.where(id: exercise_log_ids).delete_all if exercise_log_ids.any?
      user.workouts.delete_all
      puts "Removed previous demo workouts and associated logs/sets"
    end

    puts "Creating sample workouts..."

    # Push workout
    push_workout = user.workouts.create!(
      name: "Push Day",
      date: 2.days.ago.to_date,
      start_time: 2.days.ago.beginning_of_day + 17.hours,
      end_time: 2.days.ago.beginning_of_day + 18.hours + 30.minutes,
      notes: "Felt strong today. Increased bench press weight and added more shoulder work."
    )

    add_exercise_with_sets(push_workout, "Bench Press",
      notes: "Focused on form and controlled descent",
      sets: [
        { set_number: 1, weight: 60, reps: 10, rest_seconds: 90 },
        { set_number: 2, weight: 70, reps: 8, rest_seconds: 120 },
        { set_number: 3, weight: 80, reps: 6, rest_seconds: 120 },
        { set_number: 4, weight: 80, reps: 5, rest_seconds: 120 }
      ]
    )

    add_exercise_with_sets(push_workout, "Incline Dumbbell Press",
      notes: "Upper chest focus",
      sets: [
        { set_number: 1, weight: 25, reps: 12, rest_seconds: 90 },
        { set_number: 2, weight: 30, reps: 10, rest_seconds: 90 },
        { set_number: 3, weight: 35, reps: 8, rest_seconds: 90 }
      ]
    )

    add_exercise_with_sets(push_workout, "Overhead Press",
      notes: "Shoulders felt strong",
      sets: [
        { set_number: 1, weight: 40, reps: 10, rest_seconds: 90 },
        { set_number: 2, weight: 45, reps: 8, rest_seconds: 90 },
        { set_number: 3, weight: 45, reps: 7, rest_seconds: 90 }
      ]
    )

    add_exercise_with_sets(push_workout, "Dumbbell Lateral Raise",
      notes: "Light weight, perfect form",
      sets: [
        { set_number: 1, weight: 10, reps: 15, rest_seconds: 60 },
        { set_number: 2, weight: 12, reps: 12, rest_seconds: 60 },
        { set_number: 3, weight: 12, reps: 12, rest_seconds: 60 }
      ]
    )

    add_exercise_with_sets(push_workout, "Tricep Pushdown With Rope",
      notes: "Focused on contraction",
      sets: [
        { set_number: 1, weight: 30, reps: 15, rest_seconds: 60 },
        { set_number: 2, weight: 35, reps: 12, rest_seconds: 60 },
        { set_number: 3, weight: 40, reps: 10, rest_seconds: 60 }
      ]
    )

    # Pull workout
    pull_workout = user.workouts.create!(
      name: "Pull Day",
      date: 1.day.ago.to_date,
      start_time: 1.day.ago.beginning_of_day + 18.hours,
      end_time: 1.day.ago.beginning_of_day + 19.hours + 15.minutes,
      notes: "Great back pump today. Added more forearm work."
    )

    add_exercise_with_sets(pull_workout, "Barbell Deadlift",
      notes: "Used mixed grip for heavy sets",
      sets: [
        { set_number: 1, weight: 100, reps: 8, rest_seconds: 120 },
        { set_number: 2, weight: 120, reps: 6, rest_seconds: 150 },
        { set_number: 3, weight: 130, reps: 4, rest_seconds: 180 }
      ]
    )

    add_exercise_with_sets(pull_workout, "Pull-Up",
      notes: "Used neutral grip",
      sets: [
        { set_number: 1, weight: 0, reps: 10, rest_seconds: 90 },
        { set_number: 2, weight: 0, reps: 8, rest_seconds: 90 },
        { set_number: 3, weight: 0, reps: 7, rest_seconds: 90 }
      ]
    )

    add_exercise_with_sets(pull_workout, "Barbell Bent Over Row",
      notes: "Focused on squeezing back",
      sets: [
        { set_number: 1, weight: 60, reps: 12, rest_seconds: 90 },
        { set_number: 2, weight: 70, reps: 10, rest_seconds: 90 },
        { set_number: 3, weight: 80, reps: 8, rest_seconds: 90 }
      ]
    )

    add_exercise_with_sets(pull_workout, "Barbell Wrist Curl",
      notes: "Light weight, high reps",
      sets: [
        { set_number: 1, weight: 20, reps: 20, rest_seconds: 60 },
        { set_number: 2, weight: 25, reps: 15, rest_seconds: 60 },
        { set_number: 3, weight: 25, reps: 15, rest_seconds: 60 }
      ]
    )

    # Leg workout
    leg_workout = user.workouts.create!(
      name: "Leg Day",
      date: Date.today,
      start_time: Date.today.beginning_of_day + 16.hours + 30.minutes,
      end_time: Date.today.beginning_of_day + 18.hours,
      notes: "Legs are going to be sore tomorrow! Added more calf work."
    )

    add_exercise_with_sets(leg_workout, "Barbell Squat",
      notes: "Focused on depth and keeping chest up",
      sets: [
        { set_number: 1, weight: 80, reps: 10, rest_seconds: 120 },
        { set_number: 2, weight: 100, reps: 8, rest_seconds: 150 },
        { set_number: 3, weight: 110, reps: 6, rest_seconds: 180 },
        { set_number: 4, weight: 110, reps: 5, rest_seconds: 180 }
      ]
    )

    add_exercise_with_sets(leg_workout, "Barbell Romanian Deadlift",
      notes: "Focused on hamstring stretch",
      sets: [
        { set_number: 1, weight: 60, reps: 12, rest_seconds: 90 },
        { set_number: 2, weight: 70, reps: 10, rest_seconds: 90 },
        { set_number: 3, weight: 80, reps: 8, rest_seconds: 90 }
      ]
    )

    add_exercise_with_sets(leg_workout, "Leg Press",
      equipment_brand: "Hammer Strength",
      notes: "Feet high on platform to target glutes more",
      sets: [
        { set_number: 1, weight: 150, reps: 12, rest_seconds: 90 },
        { set_number: 2, weight: 180, reps: 10, rest_seconds: 120 },
        { set_number: 3, weight: 200, reps: 8, rest_seconds: 120 },
        { set_number: 4, weight: 220, reps: 6, rest_seconds: 120 }
      ]
    )

    add_exercise_with_sets(leg_workout, "Standing Calf Raise",
      notes: "Full range of motion",
      sets: [
        { set_number: 1, weight: 100, reps: 20, rest_seconds: 60 },
        { set_number: 2, weight: 120, reps: 15, rest_seconds: 60 },
        { set_number: 3, weight: 140, reps: 12, rest_seconds: 60 },
        { set_number: 4, weight: 160, reps: 10, rest_seconds: 60 }
      ]
    )

    puts "Created #{user.workouts.count} demo workouts for #{DEMO_EMAIL}"
  end
end

