class CreateExerciseSets < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_sets do |t|
      t.references :exercise_log, null: false, foreign_key: true
      t.integer :set_number, null: false
      t.integer :reps, null: false
      t.decimal :weight, precision: 8, scale: 2, null: false
      t.integer :rest_seconds
      t.integer :duration_seconds
      t.string :notes

      t.timestamps
    end

    add_index :exercise_sets, [:exercise_log_id, :set_number]
  end
end
