class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_market, :get_all_market
  after_filter :show_default_market

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def current_market
  	if session[:market_id]
  		@current_market ||= Market.find(session[:market_id])
  	else
  		@current_market ||= Market.first
  	end
  end

  def get_all_market
  	@markets ||= Market.all
  end

  private 

  def show_default_market
  	logger.info "Default market is #{@current_market.name.upcase}"
  end
end
