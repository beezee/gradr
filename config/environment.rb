# Load the Rails application.
require File.expand_path('../application', __FILE__)

Gradr::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.mandrillapp.com',
    port: 587,
    user_name: 'brian.zeligson@gmail.com',
    password: '6e7d35d5-e012-4851-a353-5cdefb04074f',
    authentication: 'plain',
    enable_starttls_auto: true }
  config.action_mailer.default_url_options = { host: 'gradr.net' }
end

# Initialize the Rails application.
Gradr::Application.initialize!
