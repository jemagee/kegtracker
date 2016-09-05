class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.references :flavor, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true
      t.decimal :percentage, precision: 7, scale: 5

      t.timestamps null: false
    end
  end
end
