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

    respond_to do |format|
      @user.skip_confirmation!
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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

end
