# == Schema Information
#
# Table name: accessories
#
#  id          :integer          not null, primary key
#  brand       :string
#  price       :integer
#  inventory   :integer
#  color       :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type_id     :integer
#  category_id :integer
#  user_id     :integer
#  board_id    :integer
#  kind_id     :integer
#

FactoryGirl.define do
  factory :accessory do
    brand "MyString"
    price 1
    inventory 1
    color "MyString"
    title "MyString"
  end
end
