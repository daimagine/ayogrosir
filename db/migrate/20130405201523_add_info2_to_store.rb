class AddInfo2ToStore < ActiveRecord::Migration
  def change
    add_column :stores, :info2, :string
  end
end
