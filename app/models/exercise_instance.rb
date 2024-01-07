# frozen_string_literal: true

class ExerciseInstance < ApplicationRecord
  belongs_to :exercise_template
  belongs_to :workout
end
