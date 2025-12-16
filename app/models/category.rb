class Category < ApplicationRecord
  KEYS = %i[
    chest
    shoulders
    rear_delts
    triceps
    lats
    lower_back
    upper_back
    biceps
    forearms
    traps
    quadriceps
    hamstrings
    glutes
    calves
    abductors
    adductors
    neck
    abdominals
    cardio
    other
  ].freeze

  SUPPORTED_NAMES = KEYS.map { |k| k.to_s.tr("_", " ") }.freeze

  has_many :exercise_categories
  has_many :exercises, through: :exercise_categories

  validates :name, presence: true, uniqueness: true, inclusion: { in: SUPPORTED_NAMES }
end
