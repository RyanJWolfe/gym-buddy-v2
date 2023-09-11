class WorkoutExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout

  has_many :exercise_sets, dependent: :destroy
end
