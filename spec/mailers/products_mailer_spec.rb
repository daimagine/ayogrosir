require "spec_helper"

describe ProductsMailer do
  before :each do
  	@product = Product.new({ 
  							:name => 'Test Product', 
  							:pic => File.new(Rails.root + 'spec/fixtures/images/model01.jpg') 
							})
  	@user = User.new({ :email => 'daimagine@gmail.com' })

  	@store = Store.new
  	@store.users << @user

  	@product.store = @store

  	@followers = @product.store.users

  end

  it "sends product new emails" do
  	@product.should_not == nil

  	@followers.empty?.should_not be_true
  	@product.name.should_not be_nil

  	puts @product.name
  	puts @followers.size

  	@product.save

  	puts ActionMailer::Base.deliveries.empty?

  	ActionMailer::Base.deliveries.empty?.should be_true
  end

end
