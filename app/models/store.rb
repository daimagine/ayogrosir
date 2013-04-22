class Store < ActiveRecord::Base
	include Timelinable
	
	attr_accessible :name, :street1, :street2, :city, :postal_code,
		:phone1, :phone2, :logo_img, :description, :info1, :page_view,
		:status, :market_id, :category_ids

	validates :name, presence: true
	validates :market_id, presence: true

	belongs_to :market
	has_many :products, :dependent => :destroy
	has_many :counters, :as => :resource
	has_and_belongs_to_many :categories, :join_table => :store_categories

  has_and_belongs_to_many :users, join_table: 'store_follow'

	def logo_img
		super || 'logo-toko.png'
	end
end