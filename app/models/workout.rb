# frozen_string_literal: true

class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_template
  has_many :exercise_instances, dependent: :destroy

  def sets
    exercise_instances
  end
end
