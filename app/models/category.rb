# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type_id    :integer
#

class Category < ApplicationRecord
  has_many :boards
  has_many :accessories
  has_many :kinds
  has_many :units
  
end
