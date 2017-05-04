# == Schema Information
#
# Table name: additions
#
#  id         :integer          not null, primary key
#  title      :string
#  price      :integer
#  inventory  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  board_id   :integer
#

FactoryGirl.define do
  factory :addition do
    title "MyString"
    price 1
    inventory 1
  end
end
