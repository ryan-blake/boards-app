# == Schema Information
#
# Table name: fins
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fin < ApplicationRecord
  has_many :boards
end
