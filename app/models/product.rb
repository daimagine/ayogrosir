class Product < ActiveRecord::Base
	include Timelinable

	attr_accessible :name, :price, :logo_img, :description, 
		:info1, :page_view, :status

	validates :name, presence: true
	validates :price, presence: true

	belongs_to :store
	has_many :counters, :as => :resource

	def logo_img
		super || 'thumb-product.png'
	end
end