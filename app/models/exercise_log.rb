class ExerciseLog < ApplicationRecord
  belongs_to :workout, counter_cache: true
  belongs_to :exercise
  has_many :sets, class_name: "ExerciseSet", dependent: :destroy

  validates :notes, length: { maximum: 500 }

  amoeba do
    enable
  end

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
    exercise_sets_count
  end
end
