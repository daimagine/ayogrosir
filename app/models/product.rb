class Product < ActiveRecord::Base
	include Timelinable

	attr_accessible :name, :price, :logo_img, :description, 
		:info1, :page_view, :status

	validates :name, presence: true
	validates :price, presence: true

	belongs_to :store

	def logo_img
		super || 'model01.png'
	end
end