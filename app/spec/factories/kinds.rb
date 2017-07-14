# == Schema Information
#
# Table name: kinds
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

FactoryGirl.define do
  factory :kind do
    name "MyString"
    references ""
    references ""
  end
end
