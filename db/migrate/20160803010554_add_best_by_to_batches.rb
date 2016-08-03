class AddBestByToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :best_by, :date
  end
end
