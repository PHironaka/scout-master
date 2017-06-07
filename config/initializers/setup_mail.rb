ActionMailer::Base.smtp_settings = {
  :address              => "smtp.sendgrid.net",
  :port                 => 587,
  :domain               => ENV["SENDGRID_DOMAIN"],
  :user_name            => ENV["SENDGRID_USERNAME"],
  :password             => ENV["SENDGRID_PASSWORD"],
  :authentication       => "plain",
  :enable_starttls_auto => true
}
