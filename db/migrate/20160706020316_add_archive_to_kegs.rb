class AddArchiveToKegs < ActiveRecord::Migration
  def change
    add_column :kegs, :archive, :boolean, default: false
  end
end
