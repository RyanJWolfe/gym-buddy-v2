class ExerciseSet < ApplicationRecord
  belongs_to :exercise_log, counter_cache: true

  def volume
    reps * weight
  end
end
