class AddArchivedToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :archived, :boolean, default: false
  end
end
