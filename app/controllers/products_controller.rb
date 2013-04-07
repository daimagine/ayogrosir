class ProductsController < ApplicationController
	before_filter :product
	before_filter :pageview_prepare

	def show
	end

	private

	def product
		@product ||= Product.find(params[:id])
	end

	def pageview_prepare
		@resource = @product
	end

end
