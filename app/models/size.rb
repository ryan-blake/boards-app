# == Schema Information
#
# Table name: sizes
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  references   :units
#  unit_id      :integer
#  category_id  :integer
#  board_id     :integer
#  feet         :integer
#  inches       :integer
#  length       :integer
#  width        :integer
#  thickness    :integer
#  volume       :integer
#  accessory_id :integer
#  access       :integer
#

class Size < ApplicationRecord
  has_many :boards
  belongs_to :unit, optional: true
  belongs_to :categories, optional: true

  after_validation :create_length

  # add pretty_size to @board
  # pretty_size  = @board.size.join @size.unit
  def create_length
    a = self
    unless a.length && a.length < 0
     if a.feet && a.feet > 0
       feet = a.feet * 12
       a.length = feet + a.inches
     else
         a.length = a.length
       end
     end
  end

end
