class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :workout_type, null: false, foreign_key: true
      t.date :date
      t.integer :duration

      t.timestamps
    end
  end
end
