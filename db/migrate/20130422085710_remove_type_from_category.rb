class RemoveTypeFromCategory < ActiveRecord::Migration
  def up
  	remove_column :categories, :type

  	add_column :categories, :cat_type, :string, :default => "Store"
  end

  def down
  	add_column :categories, :type, :string

  	remove_column :categories, :cat_type
  end
end
