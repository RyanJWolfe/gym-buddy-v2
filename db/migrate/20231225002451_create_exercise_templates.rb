# frozen_string_literal: true

class CreateExerciseTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_templates do |t|
      t.string :name
      t.string :muscle_group
      t.string :equipment
      t.text :notes

      t.timestamps
    end
  end
end
