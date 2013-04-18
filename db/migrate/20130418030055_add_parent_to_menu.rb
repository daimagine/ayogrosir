class AddParentToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :parent, :boolean, :default => false
  end
end
