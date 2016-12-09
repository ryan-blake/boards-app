# == Schema Information
#
# Table name: charges
#
#  id             :integer          not null, primary key
#  item           :string
#  price          :integer
#  user_id        :integer
#  vendor_id      :integer
#  token          :string
#  customer_id    :string
#  completed      :boolean
#  stripe_user_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Charge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
