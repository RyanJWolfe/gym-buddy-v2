# frozen_string_literal: true

class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.date :date
      t.text :notes
      t.integer :duration
      t.references :user, null: false, foreign_key: true
      t.references :workout_template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
