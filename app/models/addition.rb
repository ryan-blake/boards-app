# == Schema Information
#
# Table name: additions
#
#  id         :integer          not null, primary key
#  title      :string
#  price      :integer
#  inventory  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  board_id   :integer
#

class Addition < ApplicationRecord
  has_many :boards, as: => :boardable
  belongs_to :user
  belongs_to :additonable, polymorphic: true

end
