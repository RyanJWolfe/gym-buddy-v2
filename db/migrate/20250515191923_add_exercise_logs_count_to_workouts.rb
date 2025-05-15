class AddExerciseLogsCountToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :exercise_logs_count, :integer, default: 0, null: false
  end
end
