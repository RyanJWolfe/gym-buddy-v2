class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_type
  has_many :exercises, dependent: :destroy
end
