class FollowersController < ApplicationController
  before_filter :store
  before_filter :authenticate_user!

  def create
    if current_user.follow_store(store)
      message = "You've follows the store successfully"
    else
      message = "You've already following this store"
    end

    flash[:success] = message
    redirect_to :back
  end

  def destroy
    if current_user.unfollow_store(store)
      message = "You've unfollow the store successfully"
    else
      message = "You haven't follow this store"
    end

    flash[:success] = message
    redirect_to :back
  end

  def store
    @store ||= Store.find params[:id]
  end
end
