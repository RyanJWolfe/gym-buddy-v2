class CreateRoutines < ActiveRecord::Migration[8.0]
  def change
    create_table :routines do |t|
      t.string :name, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :routines, [:user_id, :name]
  end
end
