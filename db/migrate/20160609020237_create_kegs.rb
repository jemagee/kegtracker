class CreateKegs < ActiveRecord::Migration
  def change
    create_table :kegs do |t|
      t.text :serial_number

      t.timestamps null: false
    end
  end
end
