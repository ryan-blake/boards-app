# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  file_id      :string
#  board_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  accessory_id :integer
#

class Image < ApplicationRecord

  belongs_to :board, optional: true
  belongs_to :accessory, optional: true
  attachment :file, type: :image
end
