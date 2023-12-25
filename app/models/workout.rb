# frozen_string_literal: true

class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_template
  has_many :sets, dependent: :destroy
  has_many :exercise_instances, through: :sets
end
