# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  file_id    :string
#  board_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
  belongs_to :board
  attachment :file
end
