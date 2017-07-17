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
#  measured    :decimal(5, 2)
#  upc         :string
#

class Accessory < ApplicationRecord

  belongs_to :board, optional: true
  belongs_to :user
  belongs_to :category
  belongs_to :unit
  belongs_to :kind
  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :kind_id, :presence => true
  validates :category_id, :presence => true
  after_validation :save_category
  after_validation :accessory_length
  after_update :accessory_length, if: ->(obj){ obj.measure_changed?}


   scope :min_length_search, ->(minimum) { where('measured >= ?', minimum) }
   scope :max_length_search, ->(maximum) { where('measured <= ?', maximum) }
   scope :min_price, ->(min) { where('price >= ?', min) }
   scope :max_price, ->(max) { where('price <= ?', max) }
   
  def save_category
    a = self
    if a.category.present?
      a.category = a.kind.category
    end
  end

private

def format_date(created)
  Time.at(created).getutc.strftime("%m/%d/%Y")
end


def accessory_length
  if self.measure.present?
 unless self.unit_id == 1
   if self.unit_id == 2
     self.measured = self.measure * 12
   elsif self.unit_id == 3
     self.measured = (self.measure / 2.54)
   else
     self.measured = (self.measure / 25.4)
   end
  else
  self.measured = self.measure
  end
 end
end


end
