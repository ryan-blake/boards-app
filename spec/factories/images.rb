# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  file_id      :string
#  board_id     :integer
#  accessory_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :image do
    file_id "MyString"
    board nil
  end
end
