class CreateRoutineSets < ActiveRecord::Migration[8.0]
  def change
    create_table :routine_sets do |t|
      t.references :routine_exercise, null: false, foreign_key: true
      t.integer :set_number
      t.integer :reps
      t.decimal :weight, precision: 8, scale: 2
      t.integer :rest_seconds

      t.timestamps
    end
  end
end
