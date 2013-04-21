class Admin::MarketsController < AdminController
  # GET /admin/markets
  # GET /admin/markets.json
  def index
    @admin_markets = Market.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_markets }
    end
  end

  # GET /admin/markets/1
  # GET /admin/markets/1.json
  def show
    @admin_market = Market.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_market }
    end
  end

  # GET /admin/markets/new
  # GET /admin/markets/new.json
  def new
    @admin_market = Market.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_market }
    end
  end

  # GET /admin/markets/1/edit
  def edit
    @admin_market = Market.find(params[:id])
  end

  # POST /admin/markets
  # POST /admin/markets.json
  def create
    @admin_market = Market.new(params[:market])

    respond_to do |format|
      if @admin_market.save
        format.html { redirect_to admin_market_path(@admin_market), notice: 'Market was successfully created.' }
        format.json { render json: @admin_market, status: :created, location: @admin_market }
      else
        format.html { render :new }
        format.json { render json: @admin_market.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/markets/1
  # PUT /admin/markets/1.json
  def update
    @admin_market = Market.find(params[:id])

    respond_to do |format|
      if @admin_market.update_attributes(params[:market])
        format.html { redirect_to admin_market_path(@admin_market), notice: 'Market was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @admin_market.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/markets/1
  # DELETE /admin/markets/1.json
  def destroy
    @admin_market = Market.find(params[:id])
    @admin_market.destroy

    respond_to do |format|
      format.html { redirect_to admin_markets_url }
      format.json { head :no_content }
    end
  end

  # add store to market
  def new_store
    @admin_market = Market.find(params[:id])
    @stores = Store.where('id not in ?', @admin_market.stores.collect(&:id))
  end

  def create_store
    @admin_market = Market.find(params[:id])
    store = Store.find(params[:store_id])

    @admin_market.stores << store unless @admin_market.stores.include? store
    if @admin_market.stores.include? store
      flash[:success] = 'Success add store to market'
    end
  end

  # remove store from market
  def remove_store
    @admin_market = Market.find(params[:id])
    store = Store.find(params[:store_id])
    
    @admin_market.stores.delete(store) if @admin_market.stores.include? store
    unless @admin_market.stores.include? store
      flash[:success] = 'Success add store to market'
    end
  end

end
