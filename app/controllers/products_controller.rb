class ProductsController < ApplicationController
	before_filter :product
	before_filter :pageview_prepare

  add_crumb 'Products', :products_path

	def show
		add_crumb @product.name
	end


	private

	def product
		@product ||= Product.find(params[:id])
	end

	def pageview_prepare
		@resource = @product
	end

end
