class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :lot
      t.references :flavor, index: true, foreign_key: true
      t.integer :gallons

      t.timestamps null: false
    end
  end
end
