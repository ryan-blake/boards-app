# == Schema Information
#
# Table name: accessories
#
#  id         :integer          not null, primary key
#  name       :string
#  brand      :string
#  color      :string
#  price      :integer
#  inventory  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :accessory do
    name "MyString"
    brand "MyString"
    color "MyString"
    price 1
    inventory "MyString"
  end
end
