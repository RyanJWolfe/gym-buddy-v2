class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.string :equipment_type, null: false
      t.text :description

      t.timestamps
    end

    add_index :exercises, :name, unique: true
    add_index :exercises, :category
    add_index :exercises, :equipment_type
  end
end
