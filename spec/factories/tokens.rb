# == Schema Information
#
# Table name: tokens
#
#  id          :integer          not null, primary key
#  price       :integer
#  item        :string
#  user_id     :integer
#  token       :string
#  customer_id :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :token do
    price 1
    item "MyString"
    user_id 1
    token "MyString"
    customer_id "MyString"
  end
end
