class AddDraftToRoutines < ActiveRecord::Migration[8.0]
  def change
    add_column :routines, :draft, :boolean, default: false, null: false
  end
end
