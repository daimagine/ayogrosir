class Admin::AdvertisesController < AdminController
  # GET /admin/advertises
  # GET /admin/advertises.json
  def index
    @admin_advertises = Advertise.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_advertises }
    end
  end

  # GET /admin/advertises/1
  # GET /admin/advertises/1.json
  def show
    @admin_advertise = Advertise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_advertise }
    end
  end

  # GET /admin/advertises/new
  # GET /admin/advertises/new.json
  def new
    @admin_advertise = Advertise.new
    @resource_type = params[:resource]

    if @admin_advertise.sequence < 1
      @admin_advertise.sequence = Advertise.maximum(:sequence)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_advertise }
    end
  end

  # GET /admin/advertises/1/edit
  def edit
    @admin_advertise = Advertise.find(params[:id])
    @resource_type = params[:resource]
  end

  # POST /admin/advertises
  # POST /admin/advertises.json
  def create
    @resource_type = params[:resource]
    data = params[:advertise]
    data.delete(:resource)
    @admin_advertise = Advertise.new(data)

    respond_to do |format|
      if @admin_advertise.save
        format.html { 
          flash[:success] = 'Advertise was successfully created.' 
          redirect_to :back, notice: 'Advertise was successfully created.' 
        }
        format.json { render json: @admin_advertise, status: :created, location: @admin_advertise }
      else
        format.html { render :action => :new, :locals => { :resource => params[:resource] } }
        format.json { render json: @admin_advertise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/advertises/1
  # PUT /admin/advertises/1.json
  def update
    @resource_type = params[:resource]
    @admin_advertise = Advertise.find(params[:id])

    respond_to do |format|
      data = params[:advertise]
      data.delete(:resource)
      if @admin_advertise.update_attributes(data)
        format.html { 
          flash[:success] = 'Advertise was successfully updated.' 
          redirect_to :back, notice: 'Advertise was successfully updated.' 
        }
        format.json { head :no_content }
      else
        format.html { render :action => :edit, :locals => { :resource => params[:resource] } }
        format.json { render json: @admin_advertise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/advertises/1
  # DELETE /admin/advertises/1.json
  def destroy
    @admin_advertise = Advertise.find(params[:id])
    @admin_advertise.destroy

    respond_to do |format|
      format.html { redirect_to admin_advertises_url }
      format.json { head :no_content }
    end
  end
end
