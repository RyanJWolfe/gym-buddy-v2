class DashboardController < ApplicationController
  def index
    @recent_workouts = current_user.workouts.includes(:exercise_logs, :routine).recent.limit(5)
    @workout_count = current_user.workouts.count
    @workout_streak = current_user.current_workout_streak
    @most_used_exercise = current_user.most_used_exercise
    @total_volume = calculate_total_volume
    @favorite_exercises = current_user.favorite_exercises(5)

    # For the progress chart
    if params[:exercise_id].present?
      @selected_exercise = Exercise.find(params[:exercise_id])
      @progress_data = exercise_progress_data(@selected_exercise)
    end

    # Workout frequency chart
    @workout_frequency = current_user.workouts
                                     .group_by_week(:date, last: 12)
                                     .count

    # Volume progression chart
    @volume_progression = current_user.workouts
                                      .joins(exercise_logs: :sets)
                                      .group_by_week("workouts.date", last: 12)
                                      .sum("exercise_sets.reps * exercise_sets.weight")
  end

  private

  def calculate_total_volume
    current_user.workouts.joins(exercise_logs: :sets)
                .sum("exercise_sets.reps * exercise_sets.weight")
  end

  def exercise_progress_data(exercise)
    logs = current_user.exercise_logs.where(exercise: exercise)
                       .includes(:workout, :sets)
                       .order("workouts.date ASC")

    logs.map do |log|
      {
        date: log.workout.date.strftime("%b %d"),
        max_weight: log.max_weight,
        total_volume: log.total_volume,
        total_reps: log.total_reps
      }
    end
  end
end
