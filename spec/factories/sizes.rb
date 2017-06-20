# == Schema Information
#
# Table name: sizes
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  references  :units
#  unit_id     :integer
#  category_id :integer
#  board_id    :integer
#  feet        :integer
#  inches      :integer
#  length      :integer
#  width       :integer
#  thickness   :integer
#  volume      :integer
#

FactoryGirl.define do
  factory :size do
    name "MyString"
  end
end
