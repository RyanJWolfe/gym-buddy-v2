class RoutineExercise < ApplicationRecord
  belongs_to :routine
  belongs_to :exercise

  validates :position, presence: true
  validates :suggested_sets, presence: true, numericality: { greater_than: 0 }
  validates :suggested_reps, presence: true, numericality: { greater_than: 0 }

  default_scope { order(position: :asc) }
end
