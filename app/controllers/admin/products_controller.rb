class Admin::ProductsController < AdminController
  # GET /admin/products
  # GET /admin/products.json
  def index
    @admin_products = Product.includes(:store).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_products }
    end
  end

  # GET /admin/products/1
  # GET /admin/products/1.json
  def show
    @admin_product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_product }
    end
  end

  # GET /admin/products/new
  # GET /admin/products/new.json
  def new
    @admin_product = Product.new
    @stores = Store.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_product }
    end
  end

  # GET /admin/products/1/edit
  def edit
    @admin_product = Product.find(params[:id])
    @stores = Store.all
  end

  # POST /admin/products
  # POST /admin/products.json
  def create
    @admin_product = Product.new(params[:product])

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to admin_product_path(@admin_product), notice: 'Product was successfully created.' }
        format.json { render json: @admin_product, status: :created, location: @admin_product }
      else
        format.html { render :new }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/products/1
  # PUT /admin/products/1.json
  def update
    @admin_product = Product.find(params[:id])

    respond_to do |format|
      if @admin_product.update_attributes(params[:product])
        format.html { redirect_to admin_product_path(@admin_product), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1
  # DELETE /admin/products/1.json
  def destroy
    @admin_product = Product.find(params[:id])
    @admin_product.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_url }
      format.json { head :no_content }
    end
  end
end
