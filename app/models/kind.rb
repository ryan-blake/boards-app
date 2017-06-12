class Kind < ApplicationRecord
  has_many :accessories
  belongs_to :category
end
