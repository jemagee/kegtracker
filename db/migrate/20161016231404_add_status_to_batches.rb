class AddStatusToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :status, :integer, default: 0
  end
end
