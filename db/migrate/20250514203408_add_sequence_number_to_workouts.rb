class AddSequenceNumberToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :sequence_number, :integer, default: 1
  end
end
