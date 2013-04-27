require "spec_helper"

describe NewsletterMailer do
  before :each do
  	@advertise = Advertise.new({ :title => 'Test Email', :adv_type => 'E', :content => 'yoo' })
  	@subscribers = [ 
  		Subscription.new({ :email => 'daimagine@gmail.com' }), 
  		Subscription.new({ :email => 'daimagine@gmail.com' })
  	]
  end

  it "sends newsletter emails" do
  	@subscribers.empty?.should_not be_true
  	@advertise.title.should_not be_nil

  	puts @advertise.title
  	puts @subscribers.size

  	NewsletterMailer.newsletter(@advertise, @subscribers)

  	puts ActionMailer::Base.deliveries.empty?

  	ActionMailer::Base.deliveries.empty?.should_not be_true
  end
end
