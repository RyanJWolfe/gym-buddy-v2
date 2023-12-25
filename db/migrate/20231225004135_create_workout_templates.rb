# frozen_string_literal: true

class CreateWorkoutTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_templates do |t|
      t.string :name

      t.timestamps
    end
  end
end
