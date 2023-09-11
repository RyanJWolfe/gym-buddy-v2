class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_type

  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises

  accepts_nested_attributes_for :workout_exercises, allow_destroy: true
end
