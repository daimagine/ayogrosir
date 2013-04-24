class AddUserTypeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :user_type, :string, :default => :member
  end

  def down
  	remove_column :users, :user_type
  end
end
