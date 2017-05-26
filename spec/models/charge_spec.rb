# == Schema Information
#
# Table name: charges
#
#  id              :integer          not null, primary key
#  price           :integer
#  item            :string
#  user_id         :integer
#  vendor_id       :integer
#  token           :string
#  customer_id     :string
#  completed       :boolean          default("f")
#  boolean         :boolean          default("f")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  board_id        :string
#  address         :string
#  shipping        :boolean
#  start_time      :datetime
#  end_time        :datetime
#  rental          :boolean
#  stripe_charge   :integer
#  charge_customer :string
#  charge_stripe   :string
#

require 'rails_helper'

RSpec.describe Charge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
