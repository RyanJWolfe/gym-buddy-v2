# frozen_string_literal: true

class ExerciseInstance < ApplicationRecord
  belongs_to :user
  belongs_to :exercise_template
  has_many :sets, dependent: :destroy
end
