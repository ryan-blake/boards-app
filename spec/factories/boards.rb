# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  make        :string
#  age         :integer
#  price       :integer
#  footgear    :boolean
#  user_id     :integer
#  description :string
#  length      :integer
#  title       :string
#  width       :integer
#  type_id     :integer
#  volume      :integer
#  arrived     :boolean
#  pending     :boolean
#  address     :string
#  city        :string
#  string      :string
#  integer     :string
#  latitude    :float
#  longitude   :float
#

FactoryGirl.define do
  factory :board do
    
  end
end
