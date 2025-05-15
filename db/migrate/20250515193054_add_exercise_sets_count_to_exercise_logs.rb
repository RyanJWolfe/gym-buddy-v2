class AddExerciseSetsCountToExerciseLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :exercise_logs, :exercise_sets_count, :integer, default: 0, null: false
  end
end
