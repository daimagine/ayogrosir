class MarketsController < ApplicationController
	def default
		logger.info params[:id]
		logger.info "Current market is #{current_market.name}"
		market = Market.find(params[:id])
		if market
			session[:market_id] = market.id
			@current_market = market
			flash[:success] = "Successfully change default market to #{current_market.name.upcase}"
		else
			flash[:error] = "Could not change default market"
		end
		logger.info "Change default market to #{current_market.name}"
		redirect_to :root
	end
end
