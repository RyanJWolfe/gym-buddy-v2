class Workout < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs, dependent: :destroy
  
  validates :name, presence: true
  validates :date, presence: true
  
  scope :recent, -> { order(date: :desc) }
  
  def total_volume
    exercise_logs.sum(&:total_volume)
  end
  
  def duration_minutes
    (end_time - start_time) / 60 if end_time && start_time
  end
end
