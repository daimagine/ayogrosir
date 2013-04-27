# config/initializers/gmail.rb
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'ayogrosir.com',
  :user_name            => 'daimagine@gmail.com', # full email address (user@your.host.name.com)
  :password             => 'lkprlnzcsltihgcz',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}