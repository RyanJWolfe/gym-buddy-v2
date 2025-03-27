class Workout < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs, dependent: :destroy
  has_many :exercises, through: :exercise_logs

  validates :name, presence: true
  validates :date, presence: true
  validates :start_time, presence: true, if: :logged_workout?
  validates :end_time, presence: true, if: :logged_workout?
  validate :end_time_after_start_time, if: :logged_workout?

  scope :recent, -> { order(date: :desc) }

  def total_volume
    exercise_logs.sum(&:total_volume)
  end

  def total_sets
    exercise_logs.sum(&:total_sets)
  end

  def calculate_duration
    return unless start_time && end_time
    self.duration = ((end_time - start_time) / 60).round # Duration in minutes
  end

  def logged_workout?
    start_time.present? || end_time.present?
  end

  private

  def end_time_after_start_time
    return unless start_time && end_time
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
