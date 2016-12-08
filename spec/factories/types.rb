# == Schema Information
#
# Table name: types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :type do
    name "MyString"
  end
end
