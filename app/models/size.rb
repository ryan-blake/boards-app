# == Schema Information
#
# Table name: sizes
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  references  :units
#  unit_id     :integer
#  category_id :integer
#  board_id    :integer
#

class Size < ApplicationRecord
  has_many :boards
  belongs_to :unit, optional: true
  belongs_to :categories, optional: true

  # add pretty_size to @board
  # pretty_size  = @board.size.join @size.unit
end
