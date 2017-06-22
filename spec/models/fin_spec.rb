# == Schema Information
#
# Table name: fins
#
#  id         :integer          not null, primary key
#  name       :string
#  board_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Fin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
