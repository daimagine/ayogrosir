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

  def new 
    @member = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  def create
    @member = User.new(params[:user])

    respond_to do |format|
      @member.skip_confirmation!
      if @member.save
        format.html { redirect_to admin_member_path(@member), notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  	@member = User.find(params[:id])
  end

  def update
    @member = User.find(params[:id])

    @member.skip_reconfirmation!
    successfully_updated = false
    flag = needs_password?(@member, params)
    logger.info "Need password? #{flag}"
    if flag
      logger.info "Update with password"
      successfully_updated = @member.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      logger.info "Update without password"
      params[:user].delete(:current_password)
      successfully_updated = @member.update_without_password(params[:user])
    end
    @member.confirm!

    respond_to do |format|
      if successfully_updated
        if @member.id == current_user.id
          # Sign in the user by passing validation in case his password changed
          sign_in @member, :bypass => true
          
          format.html {
            flash[:success] = 'Your account was successfully updated.'
            redirect_to profile_admin_member_path(@member) 
          }
          format.json { render json: @member, status: :created, location: @member }
        else
          format.html {
            flash[:success] = 'Member was successfully updated.'
            redirect_to admin_member_path(@member) 
          }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
      else
        if @member.id == current_user.id
          format.html {
            flash[:error] = 'Your account cannot be updated. Please try again.'
            redirect_to profile_admin_member_path(@member) 
          }
          format.json { render json: @member, status: :created, location: @member }
        else
          format.html { render :edit }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
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


  def profile
    @member = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @member }
    end
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    # user.email != params[:user][:email] ||
    return !params[:user][:password].blank?
    logger.info "Password : [#{params[:user][:password]}] is not blank? #{!params[:user][:password].blank?}"
  end
end