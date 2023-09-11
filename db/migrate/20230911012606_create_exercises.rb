class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.references :workout, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
