class ExerciseLog < ApplicationRecord
  belongs_to :workout, counter_cache: true
  belongs_to :exercise
  has_many :sets, -> { order("set_number") }, class_name: "ExerciseSet", dependent: :destroy

  accepts_nested_attributes_for :sets, allow_destroy: true

  validates :notes, length: { maximum: 500 }

  amoeba do
    enable
    set exercise_sets_count: 0
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

  def name
    exercise.name
  end

  def reindex_sets!
    # TODO: Optimize this to do it in a single query (use act_as_list?)
    sets.order(:set_number).each_with_index do |set, index|
      set.update_column(:set_number, index + 1) if set.set_number != index + 1
    end
  end
end
