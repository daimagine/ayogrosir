class PagesController < ApplicationController
	before_filter :page

	def index
		if @page && ! @page.nil?
			add_crumb @page.slug
		else
			flash[:error] = 'The page you requested is not found'
			redirect_to :root
		end
	end

	# GET
	def contact
		@contact = Contact.new
	end

	# POST
	def submit_contact
		@contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { 
        	flash[:success] = 'Thank you for contacting us.'
        	redirect_to contact_path 
        }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { 
        	flash[:error] = 'Please provide valid information.'
        	redirect_to contact_path 
        }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
	end

	private

	def page
		@page ||= Page.where('slug = ?', params[:slug]).limit(1)[0]
	end

	# def pageview_prepare
	# 	@resource = @page
	# end

end
