# == Schema Information
#
# Table name: conversations
#
#  id           :integer          not null, primary key
#  recipient_id :integer
#  sender_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :conversation do
    recipient_id 1
    sender_id 1
  end
end
