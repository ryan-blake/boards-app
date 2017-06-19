# == Schema Information
#
# Table name: sizes
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  references  :units
#  unit_id     :integer
#  category_id :integer
#  board_id    :integer
#

require 'rails_helper'

RSpec.describe Size, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
