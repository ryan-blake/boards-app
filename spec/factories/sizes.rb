# == Schema Information
#
# Table name: sizes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  references :units
#

FactoryGirl.define do
  factory :size do
    name "MyString"
  end
end
