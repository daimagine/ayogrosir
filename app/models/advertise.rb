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
										:default_url => "/assets/banner-:style.png",
										:convert_options => {
     									:medium => '  -gravity south  -pointsize 20 -fill black -annotate +0+0 " ayogrosir.com " ' ,
     									:small => '  -gravity south  -pointsize 15 -fill black -annotate +0+0 " ayogrosir.com " ' ,
     									:thumb => '  -gravity south  -pointsize 9 -fill black -annotate +0+0 " ayogrosir.com "'
     								}

	def image
		super || 'thumb-product.png'
	end
end
