class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_menus, :initialize_preferences
  before_filter :current_market
  before_filter :show_default_market, :pageview_increment
  before_filter :initialize_app_counter
  before_filter :initialize_market, :initialize_store

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def initialize_preferences
    @preferences ||= Preference.all
  end

  def initialize_menus
    @navigation ||= Menu.all
  end

  def initialize_app_counter
    @app_counter = Counter.where('resource_type = ?', 'Application').count
    logger.info "Total unique visitor is #{@app_counter}"
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
    if check_root?
    end
  end

  def initialize_store
    if check_root? || check_pages?
      @latest_stores ||= Store.latest.limit(5)
      @newest_stores ||= Store.newest.limit(5)
      @popular_stores ||= Store.popular.limit(5)
    end
  end

  private 

  def check_root?
    params[:controller].eql?('home') and params[:action].eql?('index')
  end

  def check_pages?
    params[:controller].eql?('pages')
  end

  def show_default_market
  	logger.info "Default market is #{@current_market.name.upcase}"
  end

  # redirect to dashboard after login
  def after_sign_in_path_for(resource)
    flash[:success] = 'You have been successfully signed in'
    admin_path
  end

  def pageview_increment
    ipaddr = request.remote_ip
    logger.info "incoming page view from ip #{ipaddr}"

    if @resource && @resource.page_view
      result = @resource.counters.where('ip_address = ?', ipaddr).limit(1)
      if !result.blank?
        # same ip
      else
        # different ip, create new counter
        logger.info "Store new resource counter for ip #{ipaddr}"
        c = Counter.new
        c.ip_address = ipaddr
        @resource.counters << c
        @resource.page_view += 1
        @resource.save
      end
    end

    # counter for whole website
    counter = Counter.where('ip_address = ? and resource_type = ?', ipaddr, 'Application').limit(1)
    if counter.blank?
      c = Counter.new
      c.ip_address = ipaddr
      c.resource_type = 'Application'
      c.save
      logger.info "Store new application counter for ip #{ipaddr}"
    end
  end
end
