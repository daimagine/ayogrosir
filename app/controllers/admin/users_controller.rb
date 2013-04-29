class Admin::UsersController < AdminController

  def index
  	@users = User.where(:user_type => :admin)
  	@subscribers = Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_stores }
    end
  end

  def show
  	@user = User.find(params[:id])

  	respond_to do |format|
  		format.html
  		format.json { render json: @user }
  	end
  end

  def new 
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])
    @user.user_type = :admin

    respond_to do |format|
      @user.skip_confirmation!
      if @user.save
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.skip_reconfirmation!
    successfully_updated = false
    flag = needs_password?(@user, params)
    logger.info "Need password? #{flag}"
    if flag
      logger.info "Update with password"
      successfully_updated = @user.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      logger.info "Update without password"
      params[:user].delete(:current_password)
      successfully_updated = @user.update_without_password(params[:user])
    end
    @user.confirm!

    respond_to do |format|
      if successfully_updated
        if @user.id == current_user.id
          # Sign in the user by passing validation in case his password changed
          sign_in @user, :bypass => true
          
          format.html {
            flash[:success] = 'Your account was successfully updated.'
            redirect_to admin_user_path(@user) 
          }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html {
            flash[:success] = 'User was successfully updated.'
            redirect_to admin_user_path(@user) 
          }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        if @user.id == current_user.id
          format.html {
            flash[:error] = 'Your account cannot be updated. Please try again.'
            redirect_to admin_user_path(@user) 
          }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

	def destroy
		@user = User.find(params[:id])
		@user.status = 'I'
		
    respond_to do |format|
      format.html { 
      	flash[:success] = 'User was successfully removed.'
      	redirect_to admin_users_url 
      }
      format.json { head :no_content }
    end
	end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    # user.email != params[:user][:email] ||
      !params[:user][:password].blank?
    logger.info "Password : #{params[:user][:password]} is blank? #{params[:user][:password].blank?}"
  end
end
