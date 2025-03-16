class UpdateWorkouts < ActiveRecord::Migration[8.0]
  def change
    # Assuming you already have a basic workouts table
    add_column :workouts, :name, :string, null: false
    add_column :workouts, :date, :date, null: false
    add_column :workouts, :start_time, :datetime
    add_column :workouts, :end_time, :datetime

    add_index :workouts, :date
  end
end
