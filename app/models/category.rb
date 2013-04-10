class Category < ActiveRecord::Base
  attr_accessible :name, :type
  has_and_belongs_to_many :stores, :join_table => :store_categories
  has_and_belongs_to_many :products, :join_table => :product_categories
end
