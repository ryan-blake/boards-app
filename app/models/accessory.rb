# == Schema Information
#
# Table name: accessories
#
#  id          :integer          not null, primary key
#  brand       :string
#  price       :integer
#  inventory   :integer
#  color       :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type_id     :integer
#  category_id :integer
#  user_id     :integer
#  board_id    :integer
#  kind_id     :integer
#  unit_id     :integer
#  measure     :decimal(5, 2)
#

class Accessory < ApplicationRecord

  belongs_to :board, optional: true
  belongs_to :user
  belongs_to :category
  belongs_to :unit, optional: true
  belongs_to :kind
  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :kind_id, :presence => true
  validates :category_id, :presence => true
  after_validation :save_category



   scope :min_length_search, ->(minimum) { where('measured >= ?', minimum) }
   scope :max_length_search, ->(maximum) { where('measured <= ?', maximum) }

  def save_category
    a = self
    if a.category
      a.category = a.kind.category
    end
  end

private

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
