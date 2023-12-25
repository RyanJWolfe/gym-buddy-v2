# frozen_string_literal: true

class CreateSets < ActiveRecord::Migration[7.0]
  def change
    create_table :sets do |t|
      t.integer :reps
      t.float :weight
      t.references :workout, null: false, foreign_key: true
      t.references :exercise_instance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
