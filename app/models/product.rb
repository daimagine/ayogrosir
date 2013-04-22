class Product < ActiveRecord::Base
	include Timelinable

	attr_accessible :name, :price, :logo_img, :description, 
		:info1, :page_view, :status, :store_id, :pic

	validates :name, presence: true
	validates :price, presence: true
	validates :store_id, presence: true

	belongs_to :store, :touch => true
	has_many :counters, :as => :resource
	has_and_belongs_to_many :categories, :join_table => :product_categories

	# paperclip
	has_attached_file :pic, 
										:styles => { 
											:thumb => "90x135#",
											:small => "360x540>"
										}, 
										:default_url => "/assets/product-:style.png"

	def logo_img
		super || 'thumb-product.png'
	end
end