# == Schema Information
#
# Table name: distances
#
#  id         :integer          not null, primary key
#  value      :integer
#  board_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Distance, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
