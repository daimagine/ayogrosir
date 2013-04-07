class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_market, :initialize_market, :initialize_store
  after_filter :show_default_market, :pageview_increment

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

  def initialize_market
  	@markets ||= Market.all
  end

  def initialize_store
    @latest_stores ||= Store.latest.limit(5)
    @newest_stores ||= Store.newest.limit(5)
    @popular_stores ||= Store.popular.limit(5)
  end

  private 

  def show_default_market
  	logger.info "Default market is #{@current_market.name.upcase}"
  end

  def pageview_increment
    if @resource && @resource.page_view
      @resource.page_view += 1
      @resource.save
    end
  end
end
