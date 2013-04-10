class StoresController < ApplicationController
	before_filter :search, only: [:index]
	before_filter :store, only: [:show, :edit, :update, :destroy]
	before_filter :pageview_prepare

	def index
		@search.update_attributes(params[:search_store])

		logger.info "Keyword     : " + @search.keywords.to_s
		logger.info "Market id   : " + @search.market_id.to_s
		logger.info "Category id : " + @search.category_id.to_s
		logger.info "Order by    : " + @search.order_by.to_s
	end

	def show
	end

	private

	def search
		@search ||= SearchStore.new(
									:market_id => @current_market.id, 
									:order_by => 'Name'
								)
	end

	def store
		@store ||= Store.find(params[:id])
	end

	def pageview_prepare
		@resource = @store
	end
end
