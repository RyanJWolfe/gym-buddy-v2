class ExerciseLog < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise
  has_many :sets, class_name: 'ExerciseSet', dependent: :destroy
  
  validates :notes, length: { maximum: 500 }
  
  def total_volume
    sets.sum(&:volume)
  end
  
  def max_weight
    sets.maximum(:weight)
  end
  
  def total_reps
    sets.sum(:reps)
  end

  def total_sets
    sets.size
  end
end 