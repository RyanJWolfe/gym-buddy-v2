class CreateWorkoutExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_exercises do |t|
      t.references :exercise, null: false, foreign_key: true, index: true
      t.references :workout, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
