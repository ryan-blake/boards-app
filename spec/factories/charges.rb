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

FactoryGirl.define do
  factory :charge do
    item "MyString"
    price ""
    user_id ""
    vendor_id ""
    token "MyString"
    customer_id "MyString"
    completed false
    stripe_user_id ""
  end
end
