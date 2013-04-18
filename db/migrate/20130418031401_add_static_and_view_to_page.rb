class AddStaticAndViewToPage < ActiveRecord::Migration
  def change
  	add_column :pages, :static, :boolean, :default => false
  	add_column :pages, :template, :string
  end
end
