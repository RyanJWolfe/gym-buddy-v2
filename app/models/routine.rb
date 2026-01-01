class Routine < ApplicationRecord
  belongs_to :user
  has_many :routine_exercises, -> { order(position: :asc) }, dependent: :destroy
  has_many :exercises, through: :routine_exercises
  has_many :workouts

  accepts_nested_attributes_for :routine_exercises, allow_destroy: true

  validates :name, presence: true, unless: :draft?
  validate :must_have_at_least_one_exercise, on: :create

  scope :recent, -> { order(updated_at: :desc) }
  scope :published, -> { where(draft: false) }

  amoeba do
    exclude_association :workouts
    exclude_association :user
  end

  def share_text
    lines = [ name, "" ]

    routine_exercises.includes(:routine_sets, :exercise).each do |re|
      exercise_name = re.exercise.name
      sets = re.routine_sets

      count_line =
        if sets.present? && sets.first&.reps&.present?
          "#{sets.size} x #{sets.first.reps.size}"
        elsif re.routine_sets.present?
          "#{sets.size} #{sets.size == 1 ? 'set' : 'sets'}"
        end

      lines << exercise_name
      lines << count_line if count_line
      lines << ""
    end

    lines.join("\n").strip
  end

  def must_have_at_least_one_exercise
    if routine_exercises.empty? || routine_exercises.all? { |re| re.marked_for_destruction? }
      errors.add(:base, "Routine must have at least one exercise")
    end
  end

  # Create a workout based on this routine
  def create_workout(user)
    # Create a new workout
    workout = user.workouts.build(
      name: name,
      date: Date.current,
      start_time: Time.current,
      status: :in_progress,
      routine: self
    )

    # Save the workout to get an ID
    return nil unless workout.save

    # Create exercise logs based on routine exercises
    routine_exercises.includes(:exercise).each_with_index do |routine_exercise, index|
      exercise_log = workout.exercise_logs.create!(
        exercise: routine_exercise.exercise,
        notes: routine_exercise.notes,
        equipment_brand: routine_exercise.equipment_brand
      )

      # Create sets based on routine exercise sets
      routine_exercise.suggested_sets.times do |set_index|
        exercise_log.sets.create!(
          set_number: set_index + 1,
          reps: routine_exercise.suggested_reps,
          weight: 0.0, # User will fill this in during the workout
          rest_seconds: routine_exercise.rest_seconds
        )
      end
    end

    workout
  end
end
