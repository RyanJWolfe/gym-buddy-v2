class CreateRoutineExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :routine_exercises do |t|
      t.references :routine, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :position, null: false, default: 0
      t.integer :suggested_sets, null: false, default: 3
      t.integer :suggested_reps, null: false, default: 10
      t.integer :rest_seconds
      t.text :notes
      t.string :equipment_brand

      t.timestamps
    end

    add_index :routine_exercises, [:routine_id, :position]
  end
end
