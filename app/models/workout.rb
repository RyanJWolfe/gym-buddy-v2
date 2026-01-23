class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :template, class_name: "Workout", optional: true
  belongs_to :routine, optional: true
  has_many :derived_workouts, class_name: "Workout", foreign_key: "template_id"
  has_many :exercise_logs, -> { order("position") }, dependent: :destroy
  has_many :exercises, through: :exercise_logs

  enum :status, [ :in_progress, :completed ]

  accepts_nested_attributes_for :exercise_logs, allow_destroy: true

  validates :name, presence: true
  validates :start_time, presence: true, if: :completed?

  scope :recent, -> { order(date: :desc) }

  amoeba do
    enable
    set exercise_logs_count: 0
  end

  def reindex_exercise_logs!
    # TODO: Optimize this to do it in a single query (use act_as_list?)
    exercise_logs.each_with_index do |exercise_log, index|
      exercise_log.update_column(:position, index + 1) if exercise_log.position != index + 1
    end
  end

  def finish_workout
    self.end_time = Time.current
  end

  def total_volume
    exercise_logs.sum(&:total_volume)
  end

  def total_exercises
    exercise_logs_count
  end

  def total_sets
    exercise_logs.sum(&:total_sets)
  end

  def duration_minutes
    duration_seconds / 60 if duration_seconds
  end

  def calculate_duration
    return unless start_time && end_time
    ((end_time - start_time) / 60).round # Duration in minutes
  end

  def duration_seconds_rounded_to_nearest_minute
    return 0 unless duration_seconds

    (duration_seconds.to_f / 60).round * 60
  end

  def template_family
    base_template = template || self
    template_name = base_template.template_name || base_template.name
    user.workouts.where("template_name = ? OR id = ?", template_name, base_template.id)
  end
end
