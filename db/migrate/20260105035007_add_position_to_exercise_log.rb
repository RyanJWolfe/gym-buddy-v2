class AddPositionToExerciseLog < ActiveRecord::Migration[8.1]
  def change
    add_column :exercise_logs, :position, :integer, null: false, default: 0
  end
end
