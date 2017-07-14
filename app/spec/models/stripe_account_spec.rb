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

require 'rails_helper'

RSpec.describe StripeAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
