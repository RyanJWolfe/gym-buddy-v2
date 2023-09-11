class CreateExerciseSets < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_sets do |t|
      t.integer :reps
      t.float :weight
      t.float :distance
      t.integer :duration
      t.references :exercise, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
