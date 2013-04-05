class HomeController < ApplicationController
  def index
    @users = User.all
    @stores = current_market.stores && current_market.stores.latest
  end
end
