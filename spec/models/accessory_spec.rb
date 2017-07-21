# == Schema Information
#
# Table name: accessories
#
#  id          :integer          not null, primary key
#  brand       :string
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
#  price       :decimal(8, 2)
#  unit_id     :integer
#  measure     :decimal(5, 2)
#  measured    :decimal(5, 2)
#  upc         :string
#

require 'rails_helper'

RSpec.describe Accessory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
