class AddContentToAdvertise < ActiveRecord::Migration
  def change
    add_column :advertises, :content, :text
  end
end
