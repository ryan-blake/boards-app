# == Schema Information
#
# Table name: distances
#
#  id         :integer          not null, primary key
#  value      :integer
#  board_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :distance do
    value 1
    board nil
  end
end
