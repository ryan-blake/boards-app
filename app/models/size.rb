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
  after_save :board_length
  after_update :board_length, if: ->(obj){ obj.length_changed?}


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

  def board_length
    if self.board_id.present?
    a = Board.find(self.board_id)
   unless self.unit_id == 1
     if self.unit_id == 2
       a.length = self.length * 12
     elsif self.unit_id == 3
       a.length = (self.length / 2.54)
     else
       a.length = (self.length / 25.4)
     end
    else
    a.length = self.length
    end
    a.save
  end
end


end
