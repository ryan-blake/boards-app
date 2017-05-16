# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  make        :string
#  used        :boolean
#  price       :integer
#  footgear    :boolean
#  user_id     :integer
#  description :string
#  length      :integer
#  title       :string
#  width       :integer
#  type_id     :integer
#  volume      :integer
#  arrived     :boolean          default("f")
#  pending     :boolean          default("f")
#  address     :string
#  city        :string
#  state       :string
#  zipcode     :integer
#  latitude    :float
#  longitude   :float
#  distance_id :integer
#  category_id :integer
#  for_sale    :boolean          default("t")
#  customer_id :string
#  shipping    :boolean
#  shipped     :boolean
#  tracking    :string
#  rental      :boolean          default("f")
#  list_time   :datetime         default("2017-05-10 01:00:12.430923")
#  inventory   :integer
#

FactoryGirl.define do
  factory :board do
    
  end
end
