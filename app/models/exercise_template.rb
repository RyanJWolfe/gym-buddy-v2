# frozen_string_literal: true

class ExerciseTemplate < ApplicationRecord
  has_many :exercise_instances, dependent: :destroy
end
