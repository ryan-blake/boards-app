# == Schema Information
#
# Table name: kinds
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

class Kind < ApplicationRecord
  has_many :accessories
  belongs_to :category
end
