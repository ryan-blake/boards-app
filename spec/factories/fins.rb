# == Schema Information
#
# Table name: fins
#
#  id         :integer          not null, primary key
#  name       :string
#  board_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :fin do
    name "MyString"
    board nil
  end
end
