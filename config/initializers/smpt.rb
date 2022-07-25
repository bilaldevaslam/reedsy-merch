# frozen_string_literal: true

# config/initializers/smtp.rb
ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  domain: 'yourdomain.com',
  user_name: ENV.fetch('SENDGRID_USERNAME', nil),
  password: ENV.fetch('SENDGRID_PASSWORD', nil),
  authentication: :login,
  enable_starttls_auto: true
}
# if you are using the API key
ActionMailer::Base.smtp_settings = {
  domain: ENV.fetch('DOMAIN', nil),
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  user_name: 'apikey',
  password: ENV.fetch('SENDGRID_API_KEY', nil)
}
