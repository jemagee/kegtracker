class ChangeStatusToIntegerKegs < ActiveRecord::Migration
  def up
  	remove_column :kegs, :status
  	add_column :kegs, :status, :integer, default: 0
  end

  def down
  	remove_column :kegs, :status
  	add_column :kegs, :status, :string, default: "Empty"
  end
end
