class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :template, class_name: "Workout", optional: true
  belongs_to :routine, optional: true
  has_many :derived_workouts, class_name: "Workout", foreign_key: "template_id"
  has_many :exercise_logs, dependent: :destroy
  has_many :exercises, through: :exercise_logs

  attr_accessor :logged_workout

  enum :status, [ :in_progress, :completed ]

  accepts_nested_attributes_for :exercise_logs, allow_destroy: true

  validates :name, presence: true # TODO
  validates :date, presence: true
  validates :start_time, presence: true, if: :logged_workout?
  validates :end_time, presence: true, if: :logged_workout?
  validate :end_time_after_start_time, if: :logged_workout?

  before_save :finish_workout, if: :status_changed?, unless: :new_record? || :in_progress?
  before_create :set_template_name

  scope :recent, -> { order(date: :desc) }

  amoeba do
    enable
    set exercise_logs_count: 0
  end

  def set_template_name
    return if template_name.present?

    if template
      self.template_name = template.template_name || template.name
    else
      self.template_name = name
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
    calculate_duration
  end

  def calculate_duration
    return unless start_time && end_time
    ((end_time - start_time) / 60).round # Duration in minutes
  end

  def logged_workout?
    logged_workout.present?
  end

  def template_family
    base_template = template || self
    template_name = base_template.template_name || base_template.name
    user.workouts.where("template_name = ? OR id = ?", template_name, base_template.id)
  end

  private

  def end_time_after_start_time
    return unless start_time && end_time
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
