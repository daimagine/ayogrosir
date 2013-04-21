class Advertise < ActiveRecord::Base
	include Timelinable

  attr_accessible :description, :image, :name, :sequence, :status, :title, :adv_type

  validates :name, presence: true


	def image
		super || 'thumb-product.png'
	end
end
