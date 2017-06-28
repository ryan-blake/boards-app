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
  belongs_to :category, optional: true
  belongs_to :unit, optional: true
  belongs_to :kind
  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :kind_id, :presence => true
  after_validation :save_category


private

  def save_category
    a = self
    a.category = a.kind.category
  end

end
