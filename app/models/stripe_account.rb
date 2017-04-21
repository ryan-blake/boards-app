# == Schema Information
#
# Table name: stripe_accounts
#
#  id             :integer          not null, primary key
#  first_name     :string
#  last_name      :string
#  business_name  :string
#  account_type   :string
#  dob_month      :integer
#  dob_day        :integer
#  dob_year       :integer
#  address_city   :string
#  string         :string
#  address_state  :string
#  address_line1  :string
#  address_postal :string
#  tos            :boolean
#  boolean        :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class StripeAccount < ApplicationRecord
  validates :first_name,
  presence: true, length: { minimum: 1, maximum: 40 }

  validates :last_name,
  presence: true, length: { minimum: 1, maximum: 40 }

  validates :business_name,
  presence: true, length: { minimum: 1, maximum: 40 }

  validates :account_type,
  presence: true, inclusion: { in: %w(individual company), message: "%{value} is not a valid account type"}

  validates :tos,
  inclusion: { in: [ true ], message: ": You must agree to the terms of service" }
end
