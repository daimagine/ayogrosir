class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :subject
      t.text :message, :null => false

      t.timestamps
    end
  end
end
