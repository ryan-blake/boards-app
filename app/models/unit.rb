# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

class Unit < ApplicationRecord
  has_many :sizes
  has_many :accessories
  belongs_to :category, optional: true
end
