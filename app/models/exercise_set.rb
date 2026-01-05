class ExerciseSet < ApplicationRecord
  belongs_to :exercise_log, counter_cache: true

  after_initialize :set_default_set_number, if: :new_record?

  def volume
    reps * weight
  end

  private

  def set_default_set_number
    self.set_number ||= 1
  end
end
