class AddStatusToKegs < ActiveRecord::Migration
  def change
    add_column :kegs, :status, :string, default: "Empty"
  end
end
