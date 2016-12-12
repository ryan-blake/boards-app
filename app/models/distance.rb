# == Schema Information
#
# Table name: distances
#
#  id         :integer          not null, primary key
#  value      :integer
#  board_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Distance < ApplicationRecord
  belongs_to :board
end
