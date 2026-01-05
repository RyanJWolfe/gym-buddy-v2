class RoutineExercise < ApplicationRecord
  belongs_to :routine
  belongs_to :exercise

  has_many :sets, class_name: "RoutineSet", dependent: :destroy
  accepts_nested_attributes_for :sets, allow_destroy: true

  validates :position, presence: true

  default_scope { order(position: :asc) }

  amoeba do
    enable
  end
end
