class Image < ApplicationRecord
  belongs_to :board
  attachment :file
end
