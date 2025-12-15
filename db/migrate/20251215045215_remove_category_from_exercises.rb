class RemoveCategoryFromExercises < ActiveRecord::Migration[8.1]
  def change
    remove_column :exercises, :category, :string
  end
end
