class AddPostStatusToAdvertise < ActiveRecord::Migration
  def change
    add_column :advertises, :post_status, :string, :default => :draft
  end
end
