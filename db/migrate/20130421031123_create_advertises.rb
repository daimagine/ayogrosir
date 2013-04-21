class CreateAdvertises < ActiveRecord::Migration
  def change
    create_table :advertises do |t|
      t.string :name
      t.string :image
      t.string :title
      t.string :description
      t.string :adv_type
      t.string :status, :default => 'A' 
      t.integer :sequence, :default => 0 

      t.timestamps
    end
  end
end
