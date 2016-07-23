class AddGramsPerGallonMeasureToFlavor < ActiveRecord::Migration
  def change
    add_column :flavors, :gpg, :integer
  end
end
