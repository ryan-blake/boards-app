if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.sendgrid.net',
    port:           587,
    authentication: :plain,
    user_name:      Rails.application.secrets.SENDGRID_USERNAME,
    password:        Rails.application.secrets.SENDGRID_PASSWORD,
    domain: 'heroku.com',
    enable_starttls_auto: true
  }
end


    # user_name: Rails.application.secrets.email_provider_username,
    # password: Rails.application.secrets.email_provider_password
