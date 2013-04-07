class AddWeightToProduct < ActiveRecord::Migration
  def change
    add_column :products, :weight, :float, precision: 10, scale: 2
  end
end
