class CreateStoreFollow < ActiveRecord::Migration
  def up
    create_table :store_follow do |t|
      t.integer :user_id
      t.integer :store_id
    end

    add_index(:store_follow, [:user_id, :store_id])
  end

  def down
    drop_index :store_follow
  end
end
