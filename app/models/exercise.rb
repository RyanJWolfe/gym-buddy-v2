class Exercise < ApplicationRecord
  belongs_to :user
  # has_many :exercise_sets, dependent: :destroy

  has_many :workout_exercises
  has_many :workouts, through: :workout_exercises
end
