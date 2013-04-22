class AddAttachmentPicToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :products, :pic
  end
end
