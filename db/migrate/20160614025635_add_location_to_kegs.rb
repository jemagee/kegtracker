class AddLocationToKegs < ActiveRecord::Migration
  def change
    add_column :kegs, :location, :string, default: "Teeccino Warehouse"
  end
end
