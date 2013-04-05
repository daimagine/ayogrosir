class StoresController < ApplicationController
	before_filter :store
	def show
	end

	private

	def store
		@store ||= Store.find(params[:id])
	end
end
