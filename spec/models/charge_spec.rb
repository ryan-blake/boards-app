# == Schema Information
#
# Table name: charges
#
#  id            :integer          not null, primary key
#  item          :string
#  user_id       :integer
#  vendor_id     :integer
#  token         :string
#  customer_id   :string
#  completed     :boolean          default("f")
#  boolean       :boolean          default("f")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  board_id      :integer
#  address       :string
#  shipping      :boolean
#  start_time    :datetime
#  end_time      :datetime
#  rental        :boolean
#  charge_stripe :string
#  accessories   :string
#  picked        :string
#  shipped       :string
#  zipcode       :string
#  country       :string
#  state         :string
#  city          :string
#  tracking      :string
#  price         :decimal(8, 2)
#

require 'rails_helper'

RSpec.describe Charge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
