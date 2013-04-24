class Admin::PreferencesController < AdminController

	def index
		@advertises = Advertise.all
	end

	def save
		if params[:settings] && ! params[:settings].blank?
			keys = []
			params[:settings].each do |key, value|
				logger.info "edit #{key}"
				p = Preference.where(:pref_key => key).first
				if p 
					p.pref_value = value
					p.save

					keys << p.name
				end
			end
			flash[:success] = "Preferences #{keys.join(', ')} successfully updated."
		else 	
			flash[:failed] = "Preferences could not be updated."
		end
		redirect_to :back
	end

end