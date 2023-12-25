# frozen_string_literal: true

class CreateExerciseInstances < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_instances do |t|
      t.integer :reps
      t.float :weight
      t.text :notes
      t.references :user, null: false, foreign_key: true
      t.references :exercise_template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
