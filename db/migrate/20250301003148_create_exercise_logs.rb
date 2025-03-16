class CreateExerciseLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_logs do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.text :notes
      t.string :equipment_brand

      t.timestamps
    end

    add_index :exercise_logs, [:workout_id, :exercise_id]
  end
end
