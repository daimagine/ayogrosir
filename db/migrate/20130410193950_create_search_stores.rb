class CreateSearchStores < ActiveRecord::Migration
  def change
    create_table :search_stores do |t|
    	t.string :keywords
    	t.integer :market_id
    	t.integer :category_id
    	t.string :order_by
      t.timestamps
    end
  end
end
