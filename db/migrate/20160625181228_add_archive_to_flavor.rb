class AddArchiveToFlavor < ActiveRecord::Migration
  def change
    add_column :flavors, :archive, :boolean, default: false
  end
end
