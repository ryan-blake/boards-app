# == Schema Information
#
# Table name: tails
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#

class Tail < ApplicationRecord
  has_many :boards
end
