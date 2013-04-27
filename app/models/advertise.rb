class Advertise < ActiveRecord::Base
	include Timelinable

  attr_accessible :description, :image, :name, :sequence, :status, :title, :adv_type, :pic, :content

  validates :name, presence: true

	# paperclip
	has_attached_file :pic, 
										:styles => { 
											:thumb => "85x75#",
											:medium => "369x220>",
											:small => "170x150>"
										}, 
										:default_url => "/assets/banner-:style.png"

	def image
		super || 'thumb-product.png'
	end
end
