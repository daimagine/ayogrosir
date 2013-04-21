class SubscriptionsController < ApplicationController

	def create
		email = params[:email]
		logger.info 'emaaaaaaaaaaaaail '
		logger.info email

		if email != nil && email != ''
			
			sub = Subscription.where(:email => email).first

			if(sub != nil) 
				flash[:success] = 'You have been subscribed with our updates. Thank You'
			else
				sub = Subscription.new({ :email => email })
				sub.save
				flash[:success] = "Subscription with email #{email} success. Thank You"
			end

		else
			flash[:error] = "Please provide valid email"
		end

		redirect_to :root
	end

end
