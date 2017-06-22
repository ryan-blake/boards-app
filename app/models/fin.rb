# == Schema Information
#
# Table name: fins
#
#  id         :integer          not null, primary key
#  name       :string
#  board_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fin < ApplicationRecord
  has_many :boards
end
