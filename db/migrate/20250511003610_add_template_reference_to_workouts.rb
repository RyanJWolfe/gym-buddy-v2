class AddTemplateReferenceToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_reference :workouts, :template, foreign_key: { to_table: :workouts }
    add_column :workouts, :template_name, :string
  end
end
