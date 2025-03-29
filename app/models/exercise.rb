class Exercise < ApplicationRecord
  has_many :exercise_logs
  has_many :workouts, through: :exercise_logs

  validates :name, presence: true, uniqueness: true

  # Exercise categories (e.g., "Legs", "Push", "Pull", "Core")
  validates :category, presence: true

  # Equipment type (e.g., "Barbell", "Dumbbell", "Machine", "Bodyweight")
  validates :equipment_type, presence: true

  scope :alphabetical, -> { order(:name) }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_equipment, ->(type) { where(equipment_type: type) }
  scope :popular, -> { joins(:exercise_logs).group(:id).order("COUNT(exercise_logs.id) DESC") }
end
