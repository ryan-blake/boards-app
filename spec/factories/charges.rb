# == Schema Information
#
# Table name: charges
#
#  id            :integer          not null, primary key
#  price         :integer
#  item          :string
#  user_id       :integer
#  vendor_id     :integer
#  token         :string
#  customer_id   :string
#  completed     :boolean          default("f")
#  boolean       :boolean          default("f")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  board_id      :string
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
#

FactoryGirl.define do
  factory :charge do
    price 1
    item "MyString"
    user nil
    vendor ""
    token "MyString"
    customer_id "MyString"
    completed false
  end
end
