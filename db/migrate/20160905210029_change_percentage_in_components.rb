class ChangePercentageInComponents < ActiveRecord::Migration
  def up
  	change_column :components, :percentage, :decimal, precision: 8, scale: 5
  end

  def down
  	change_column :components, :percentage, :decimal, precision: 7, scale: 5
  end
end
