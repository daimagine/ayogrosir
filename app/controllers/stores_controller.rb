class StoresController < ApplicationController
	before_filter :store
	before_filter :pageview_prepare

	def show
	end

	private

	def store
		@store ||= Store.find(params[:id])
	end

	def pageview_prepare
		@resource = @store
	end
end
