# == Schema Information
#
# Table name: tails
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#

require 'rails_helper'

RSpec.describe Tail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
