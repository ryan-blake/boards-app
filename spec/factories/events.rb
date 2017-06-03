# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  start_time :datetime
#  end_time   :datetime
#  tag        :string
#  repeat     :string
#  payed      :boolean          default("f")
#  booked     :boolean          default("f")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  board_id   :integer
#  charge_id  :integer
#  name       :string
#  vendor_id  :integer
#  price      :integer
#

FactoryGirl.define do
  factory :event do
    start_time "2017-04-03 11:53:57"
    end_time "2017-04-03 11:53:57"
    tag "MyString"
    string "MyString"
    payed false
    booked false
  end
end
