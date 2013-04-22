class AddAttachmentPicToStores < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :stores, :pic
  end
end
