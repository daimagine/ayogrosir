class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.string :pref_key, :null => false
      t.string :pref_value
      t.string :name
      t.string :description
      t.string :status, :default => 'A'

      t.timestamps
    end
  end
end
