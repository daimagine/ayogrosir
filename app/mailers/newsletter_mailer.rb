class NewsletterMailer < ActionMailer::Base
  default :from => "news@ayogrosir.com",
  				:to => "daimagine@gmail.com"

  def newsletter(advertise, subscribers)
  	subscribers.each do |s|
  		logger.info "Send email to #{s.email}"
  		mail( :subject => advertise.title, :to => s.email ).deliver
  	end
  end
end
