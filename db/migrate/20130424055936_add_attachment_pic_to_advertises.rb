class AddAttachmentPicToAdvertises < ActiveRecord::Migration
  def self.up
    change_table :advertises do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :advertises, :pic
  end
end
