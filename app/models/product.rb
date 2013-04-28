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

	after_create :blast_email										

	def logo_img
		super || 'thumb-product.png'
	end

	private 

	def blast_email
		@followers = self.store.users
		logger.info "Send email update notification to #{@followers.size} followers"

		logger.debug self.pic

    # Do blast email
    ProductsMailer.new(self)
	end
end