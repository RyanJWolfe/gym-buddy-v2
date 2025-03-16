class ExerciseSet < ApplicationRecord
  belongs_to :exercise_log

  validates :reps, presence: true, numericality: { greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :set_number, presence: true, numericality: { greater_than: 0 }

  # Optional fields
  validates :rest_seconds, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :duration_seconds, numericality: { greater_than: 0 }, allow_nil: true

  default_scope { order(set_number: :asc) }

  def volume
    reps * weight
  end
end
