# == Schema Information
#
# Table name: fins
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :fin do
    name "MyString"
    board nil
  end
end
