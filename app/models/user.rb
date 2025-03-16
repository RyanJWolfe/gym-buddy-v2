class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :workouts, dependent: :destroy
  has_many :exercise_logs, through: :workouts
  has_many :exercises, -> { distinct }, through: :exercise_logs

  def favorite_exercises(limit = 5)
    exercises.joins(:exercise_logs)
            .where(exercise_logs: { workout_id: workouts.pluck(:id) })
            .group("exercises.id")
            .order("COUNT(exercise_logs.id) DESC")
            .limit(limit)
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
