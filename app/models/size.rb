# == Schema Information
#
# Table name: sizes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  references :units
#

class Size < ApplicationRecord
  has_many :boards
  belongs_to :unit
end
