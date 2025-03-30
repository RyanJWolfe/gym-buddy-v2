class AddStatusToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :status, :integer, default: 1
  end
end
