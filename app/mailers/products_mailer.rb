class ProductsMailer < ActionMailer::Base
  default :from => "news@ayogrosir.com",
  				:to => "daimagine@gmail.com"

  def new(product)
  	logger.info "Send email product #{product.name}"
  	logger.info "Product picture #{product.pic}"
  	followers = product.store.users

  	# prepare data for view
  	@product = product
  	@followers = followers

  	p_pic = product.pic.path.to_s
  	logo_pic = Rails.root.join('app', 'assets', 'images', 'ayogrosir-header.jpg')
  	
  	logger.info "Load product picture path #{p_pic}"
  	logger.info "Load Logo picture path #{logo_pic}"

  	# attachments.inline['ayogrosir_logo'] = File.read(logo_pic)
  	# attachments.inline['product_picture'] = File.read(p_pic)

  	@root_url = root_url
  	logger.info "Root URL #{root_url}"

  	# blast email
  	followers.each do |s|
  		logger.info "Send email update to #{s.email}"
  		mail( :subject => "Produk Baru #{product.store.name} di AyoGrosir", :to => s.email ).deliver
  	end
  end
end
