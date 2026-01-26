class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :routines, dependent: :destroy

  has_many :workouts, dependent: :destroy
  has_many :exercise_logs, through: :workouts
  has_many :exercises, -> { distinct }, through: :exercise_logs

  def initials
    email.split("@").first[0..1].upcase
  end

  def name
    email.split("@").first.capitalize
  end

  def current_workout_streak
    streak = 0
    current_date = Date.current

    loop do
      break unless workouts.exists?(date: current_date)

      streak += 1
      current_date -= 1.day
    end

    streak
  end

  def most_used_exercise
    favorite_exercises(1).first
  end

  def favorite_exercises(limit = 5)
    exercises.joins(:exercise_logs)
             .where(exercise_logs: { workout_id: workouts.select(:id) })
             .select('exercises.name AS name, COUNT(exercise_logs.id) AS total_count')
             .group('exercises.id, exercises.name')
             .reorder(Arel.sql('total_count DESC'))
             .limit(limit)
             .map { |e| { name: e.name, total_count: e.total_count.to_i } }
  end

  def recent_max_weight(exercise)
    exercise_logs.where(exercise: exercise)
                 .joins(:sets)
                 .order("workouts.date DESC")
                 .limit(1)
                 .pick("MAX(exercise_sets.weight)")
  end

  def personal_record(exercise)
    exercise_logs.where(exercise: exercise)
                 .joins(:sets)
                 .pick("MAX(exercise_sets.weight)")
  end

  def exercise_progress(exercise, limit = 10)
    logs = exercise_logs.where(exercise: exercise)
                        .includes(:workout, :sets)
                        .order("workouts.date DESC")
                        .limit(limit)

    logs.map do |log|
      {
        date: log.workout.date,
        max_weight: log.max_weight,
        total_volume: log.total_volume
      }
    end.reverse
  end
end
