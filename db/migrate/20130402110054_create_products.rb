class CreateProducts < ActiveRecord::Migration
  def up
  	create_table :products do |t|
      t.integer :store_id
      t.string :name, null: false
      t.decimal :price, precision: 14, scale: 2, null: false
      t.string :logo_img
      t.text :description
      t.text :info1
      t.integer :page_view, default: 0
      t.string :status

      t.timestamps
    end
  end

  def down
  	drop_table :products
  end
end
