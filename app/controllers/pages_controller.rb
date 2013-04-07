class PagesController < ApplicationController
	before_filter :page
	# before_filter :pageview_prepare

	def index
		if @page && ! @page.nil?
		else
			flash[:error] = 'The page you requested is not found'
			redirect_to :root
		end
	end

	private

	def page
		@page ||= Page.where('slug = ?', params[:slug]).limit(1)[0]
	end

	# def pageview_prepare
	# 	@resource = @page
	# end

end
