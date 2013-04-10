class Market < ActiveRecord::Base
	include Timelinable
	
	attr_accessible :name, :street1, :street2, :city, :postal_code,
		:phone1, :phone2, :logo_img, :description, :info1, :page_view,
		:status

	validates :name, presence: true

	has_many :stores, :dependent => :destroy
	has_many :counters, :as => :resource

end