class Admin::EmailMarketingsController < AdminController
  # GET /admin/email_marketings
  # GET /admin/email_marketings.json
  def index
    @admin_email_marketings = Advertise.where(:adv_type => 'E')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_email_marketings }
    end
  end

  # GET /admin/email_marketings/1
  # GET /admin/email_marketings/1.json
  def show
    @admin_email_marketing = Advertise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_email_marketing }
    end
  end

  # GET /admin/email_marketings/new
  # GET /admin/email_marketings/new.json
  def new
    @admin_email_marketing = Advertise.new
    @admin_email_marketing.adv_type = 'E'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_email_marketing }
    end
  end

  # GET /admin/email_marketings/1/edit
  def edit
    @admin_email_marketing = Advertise.find(params[:id])
  end

  # POST /admin/email_marketings
  # POST /admin/email_marketings.json
  def create
    @admin_email_marketing = Advertise.new(params[:advertise])
    @admin_email_marketing.adv_type = 'E'

    respond_to do |format|
      if @admin_email_marketing.save
        format.html { redirect_to admin_email_marketing_path(@admin_email_marketing), notice: 'Email marketing was successfully created.' }
        format.json { render json: @admin_email_marketing, status: :created, location: @admin_email_marketing }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_email_marketing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/email_marketings/1
  # PUT /admin/email_marketings/1.json
  def update
    @admin_email_marketing = Advertise.find(params[:id])

    respond_to do |format|
      if @admin_email_marketing.update_attributes(params[:advertise])
        format.html { redirect_to admin_email_marketing_path(@admin_email_marketing), notice: 'Email marketing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_email_marketing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/email_marketings/1
  # DELETE /admin/email_marketings/1.json
  def destroy
    @admin_email_marketing = Advertise.find(params[:id])
    @admin_email_marketing.destroy

    respond_to do |format|
      format.html { redirect_to admin_email_marketings_url }
      format.json { head :no_content }
    end
  end

  # POST /admin/email_marketings/1/blast
  # POST /admin/email_marketings/1/blast.json
  def blast
    @admin_email_marketing = Advertise.find(params[:id])
    @subscribers = Subscription.all

    # Do blast email
    NewsletterMailer.newsletter(@admin_email_marketing, @subscribers)

    # Flag email marketing as :publish
    @admin_email_marketing.post_status = :publish
    @admin_email_marketing.save

    respond_to do |format|
      format.html { 
        flash[:info] = "Email marketing has been blasted to #{@subscribers.size} subscribers"
        redirect_to :back 
      }
      format.json { head :no_content }
    end
  end

end
