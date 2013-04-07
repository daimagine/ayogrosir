class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :content, null: false
      t.integer :page_view, default: 0
      t.string :status, default: 'A'

      t.timestamps
    end
  end

  def down
    drop_table :pages
  end
end
