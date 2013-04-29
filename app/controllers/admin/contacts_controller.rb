class Admin::ContactsController < AdminController
  def index
  	@contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  def show
  	@contacts = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contacts }
    end
  end

  def destroy
  	@contacts = Contact.find(params[:id])
    @contacts.destroy

    respond_to do |format|
      format.html { 
      	flash[:info] = "Contact message has been removed"
      	redirect_to admin_contacts_url 
      }
      format.json { head :no_content }
    end
  end
end
