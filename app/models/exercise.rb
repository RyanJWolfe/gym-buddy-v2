class Exercise < ApplicationRecord
  has_many :exercise_logs
  has_many :workouts, through: :exercise_logs

  has_many :exercise_categories
  has_many :categories, through: :exercise_categories

  validates :name, presence: true, uniqueness: true

  # Equipment type (e.g., "Barbell", "Dumbbell", "Machine", "Bodyweight")
  validates :equipment_type, presence: true

  enum :equipment_type, %i[ barbell dumbbell bodyweight machine cable resistance_band kettlebell plate other]

  scope :alphabetical, -> { order(:name) }
  scope :by_category, ->(category_name) { joins(:categories).where(categories: { name: category_name }) }
  scope :by_equipment, ->(type) { where(equipment_type: type) }
  scope :popular, -> { joins(:exercise_logs).group(:id).order("COUNT(exercise_logs.id) DESC") }

  def primary_category
    categories.first
  end
end
