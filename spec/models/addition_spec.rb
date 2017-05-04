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

require 'rails_helper'

RSpec.describe Addition, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
