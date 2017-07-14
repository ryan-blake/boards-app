# == Schema Information
#
# Table name: sizes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#  unit_id    :integer          default("1")
#  feet       :integer
#  inches     :integer
#  length     :decimal(5, 2)
#  width      :decimal(5, 2)
#  thickness  :decimal(5, 2)
#  volume     :decimal(5, 2)
#

FactoryGirl.define do
  factory :size do
    name "MyString"
  end
end
