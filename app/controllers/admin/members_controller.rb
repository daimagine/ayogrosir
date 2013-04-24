class Admin::MembersController < AdminController
  
  def index
  	@members = User.where(:user_type => :member)
  	@subscribers = Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_stores }
    end
  end

  def show
  	@member = User.find(params[:id])

  	respond_to do |format|
  		format.html
  		format.json { render json: @member }
  	end
  end

  def edit
  	@member = User.find(params[:id])
  end

  def update
  	@member = User.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to admin_member_path(@member), notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

	def destroy
		@member = User.find(params[:id])
		@member.status = 'I'
		
    respond_to do |format|
      format.html { 
      	flash[:success] = 'Member was successfully removed.'
      	redirect_to admin_members_url 
      }
      format.json { head :no_content }
    end
	end


  # subscriptions
  def subscriber_show
  	@subscriber = Subscription.find(params[:id])

  	respond_to do |format|
  		format.html
  		format.json { render json: @subscriber }
  	end
  end

  def subscriber_edit
  	@subscriber = Subscription.find(params[:id])
  end

  def subscriber_update
  	@subscriber = Subscription.find(params[:id])

  	respond_to do |format|
  		if @subscriber.update_attributes(params[:subscriber])
  			format.html { redirect_to subscriber_admin_members_path(@subscriber), notice: 'Subscription was successfully updated.' }
  			format.json { head :no_content }
  		else
  			format.html { render :subscriber_edit }
  			format.json { render json: @subscriber, status: :unprocessable_entity }
  		end
  	end
	end

	def subscriber_destroy
		@subscriber = Subscription.find(params[:id])
		@subscriber.destroy

    respond_to do |format|
      format.html { 
      	flash[:success] = 'Member was successfully removed.'
      	redirect_to admin_members_url 
      }
      format.json { head :no_content }
    end
	end

	def subscriber_unfollow
		@subscriber = Subscription.find(params[:id])
		@subscriber.destroy

    respond_to do |format|
      format.html { 
      	flash[:success] = 'Member was successfully removed.'
      	redirect_to admin_members_url 
      }
      format.json { head :no_content }
    end
	end

end