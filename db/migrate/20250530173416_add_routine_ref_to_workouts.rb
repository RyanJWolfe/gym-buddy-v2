class AddRoutineRefToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_reference :workouts, :routine, null: true, foreign_key: true
  end
end
