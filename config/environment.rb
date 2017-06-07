# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Configuration for using SendGrid on Heroku
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "yourSendGridusernameyougetfromheroku",
  :password => "yourSendGridpasswordyougetfromheroku",
  :domain => "staging.freelanceful.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
