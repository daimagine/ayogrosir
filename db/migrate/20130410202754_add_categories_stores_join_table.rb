class AddCategoriesStoresJoinTable < ActiveRecord::Migration
  def self.up
    create_table :store_categories, :id => false do |t|
      t.integer :category_id
      t.integer :store_id
    end

    create_table :product_categories, :id => false do |t|
      t.integer :category_id
      t.integer :product_id
    end
  end
 
  def self.down
    drop_table :store_categories

    drop_table :product_categories
  end
end
