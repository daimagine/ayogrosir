class CreateStores < ActiveRecord::Migration
  def up
  	create_table :stores do |t|
      t.integer :market_id
      t.string :name, null: false
      t.string :street1
      t.string :street2
      t.string :city
      t.string :postal_code
      t.string :phone1
      t.string :phone2
      t.string :logo_img
      t.text :description
      t.text :info1
      t.integer :page_view, default: 0
      t.string :status

      t.timestamps
    end
  end

  def down
  	drop_table :stores
  end
end
