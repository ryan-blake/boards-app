# == Schema Information
#
# Table name: charges
#
#  id          :integer          not null, primary key
#  price       :integer
#  item        :string
#  user_id     :integer
#  vendor_id   :integer
#  token       :string
#  customer_id :string
#  completed   :boolean          default("f")
#  boolean     :boolean          default("f")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  board_id    :string
#  address     :string
#  shipping    :boolean
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
