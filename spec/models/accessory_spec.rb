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
#

require 'rails_helper'

RSpec.describe Accessory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
