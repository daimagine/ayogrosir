class Admin::StoresController < AdminController
  # GET /admin/stores
  # GET /admin/stores.json
  def index
    @admin_stores = Store.includes(:market, :categories).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_stores }
    end
  end

  # GET /admin/stores/1
  # GET /admin/stores/1.json
  def show
    @admin_store = Store.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_store }
    end
  end

  # GET /admin/stores/new
  # GET /admin/stores/new.json
  def new
    @admin_store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_store }
    end
  end

  # GET /admin/stores/1/edit
  def edit
    @admin_store = Store.find(params[:id])
  end

  # POST /admin/stores
  # POST /admin/stores.json
  def create
    @admin_store = Store.new(params[:store])

    respond_to do |format|
      # validate featured
      if validate_featured
        if @admin_store.save
          format.html { 
            flash[:success] = 'Store was successfully created.'
            redirect_to :back
          }
          format.json { render json: @admin_store, status: :created, location: @admin_store }
        else
          format.html { render :new }
          format.json { render json: @admin_store.errors, status: :unprocessable_entity }
        end
      else
        format.html { 
          flash[:error] = 'Only 5 featured stores is allowed'
          redirect_to :back
        }
        format.json { render json: @admin_store, status: :created, location: @admin_store }
      end
    end
  end

  # PUT /admin/stores/1
  # PUT /admin/stores/1.json
  def update
    @admin_store = Store.find(params[:id])

    respond_to do |format|
      # validate featured
      if validate_featured
        if @admin_store.update_attributes(params[:store])
          format.html { 
            flash[:success] = 'Store was successfully updated.'
            redirect_to :back
          }
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @admin_store.errors, status: :unprocessable_entity }
        end
      else
        format.html { 
          flash[:error] = 'Only 5 featured stores is allowed'
          redirect_to :back
        }
        format.json { render json: @admin_store, status: :created, location: @admin_store }
      end
    end
  end

  # DELETE /admin/stores/1
  # DELETE /admin/stores/1.json
  def destroy
    @admin_store = Store.find(params[:id])
    @admin_store.destroy

    respond_to do |format|
      format.html { redirect_to admin_stores_url }
      format.json { head :no_content }
    end
  end


  def featured
    @admin_stores = Store.includes(:market, :categories).where(:store_type => :featured)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_stores }
    end
  end

  def clean
    pref = Preference.where(:pref_key => 'store_subscription_time').first
    # set default
    limit = if pref == nil then 180 else pref.pref_value.to_i end

    logger.info "Store limit time #{limit} days"

    store_ids = Store.where('created_at < ?', ( Time.now - limit.days) ).map(&:id)
    logger.info "Store ids #{store_ids.join(', ')}"

    logger.info "Remove products"
    Product.delete_all(['store_id = ?', store_ids])

    render :nothing => true
  end

  private

  def validate_featured
    logger.info "check if select as featured : #{@admin_store.store_type.eql?('featured')}"
    if @admin_store.store_type.eql?('featured')
      if @admin_store.id != nil
        count = Store.where('store_type == ? and id <> ?', :featured, @admin_store.id).count
      else
        count = Store.where('store_type == ?', :featured).count
      end
    else
      count = 0
    end
    return true if(count < 5)
    return false
  end
end
