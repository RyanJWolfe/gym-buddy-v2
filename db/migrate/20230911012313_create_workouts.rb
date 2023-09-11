class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :workout_type, null: false, foreign_key: true, index: true
      t.date :date, null: false, index: true
      t.integer :duration

      t.timestamps
    end
  end
end
