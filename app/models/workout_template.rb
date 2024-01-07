# frozen_string_literal: true

class WorkoutTemplate < ApplicationRecord
  belongs_to :user
  has_many :workouts, dependent: :destroy
end
