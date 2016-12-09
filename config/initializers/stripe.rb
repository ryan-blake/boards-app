require "stripe"

Rails.configuration.stripe = {
  publishable_key: Rails.application.secrets.STRIPE_PUBLISHABLE_KEY,
  secret_key:      Rails.application.secrets.STRIPE_API_KEY

}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
