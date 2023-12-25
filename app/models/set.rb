# frozen_string_literal: true

class Set < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise_instance
end
