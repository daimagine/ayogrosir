class HomeController < ApplicationController
	def index
    @users = User.all
    @stores = current_market.stores && current_market.stores.latest
    @advertise = Advertise.where('adv_type = ?', 'S').order('sequence ASC')
    @banner_top = Advertise.where(:adv_type => 'B1').first
    @banner_topleft = Advertise.where(:adv_type => 'B2').first
    @banner_topright = Advertise.where(:adv_type => 'B3').first

    @search = SearchStore.new( :market_id => @current_market.id,  :order_by => 'Name' )
  end
end
