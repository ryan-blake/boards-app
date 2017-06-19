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
#  list_time   :datetime         default("2017-06-02 18:29:30")
#  inventory   :integer          default("0")
#  cost        :integer
#  margin      :integer
#  upc         :string
#  company     :string
#  references  :size
#

FactoryGirl.define do
  factory :board do
    
  end
end
