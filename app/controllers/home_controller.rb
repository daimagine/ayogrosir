class HomeController < ApplicationController
  def index
    @users = User.all
    @markets = Market.most_update
  end
end
