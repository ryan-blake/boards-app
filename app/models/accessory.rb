# == Schema Information
#
# Table name: accessories
#
#  id         :integer          not null, primary key
#  name       :string
#  brand      :string
#  color      :string
#  price      :integer
#  inventory  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Accessory < ApplicationRecord
  belongs_to :board, optional: true
  has_many :types, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  accepts_nested_attributes_for :images, allow_destroy: true

end
