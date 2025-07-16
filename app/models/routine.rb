class Routine < ApplicationRecord
  belongs_to :user
  has_many :routine_exercises, -> { order(position: :asc) }, dependent: :destroy
  has_many :exercises, through: :routine_exercises
  has_many :workouts

  validates :name, presence: true, unless: :draft?

  scope :recent, -> { order(updated_at: :desc) }

  # Create a workout based on this routine
  def create_workout(user)
    # Create a new workout
    workout = user.workouts.build(
      name: name,
      date: Date.current,
      start_time: Time.current,
      status: :in_progress,
      routine: self
    )

    # Save the workout to get an ID
    return nil unless workout.save

    # Create exercise logs based on routine exercises
    routine_exercises.includes(:exercise).each_with_index do |routine_exercise, index|
      exercise_log = workout.exercise_logs.create!(
        exercise: routine_exercise.exercise,
        notes: routine_exercise.notes,
        equipment_brand: routine_exercise.equipment_brand
      )

      # Create sets based on routine exercise sets
      routine_exercise.suggested_sets.times do |set_index|
        exercise_log.sets.create!(
          set_number: set_index + 1,
          reps: routine_exercise.suggested_reps,
          weight: 0.0, # User will fill this in during the workout
          rest_seconds: routine_exercise.rest_seconds
        )
      end
    end

    workout
  end
end
