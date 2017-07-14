# == Schema Information
#
# Table name: tails
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tail < ApplicationRecord
  has_many :boards
end
