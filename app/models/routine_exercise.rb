class RoutineExercise < ApplicationRecord
  belongs_to :routine
  belongs_to :exercise

  has_many :routine_sets, dependent: :destroy
  accepts_nested_attributes_for :routine_sets, allow_destroy: true

  validates :position, presence: true

  default_scope { order(position: :asc) }
end
