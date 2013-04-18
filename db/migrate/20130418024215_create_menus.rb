class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name, :null => false
      t.string :url
      t.integer :sequence, :default => 0
      t.integer :parent_id, :default => 0
      t.string :status, :default => 'A'     

      t.timestamps
    end
  end
end
