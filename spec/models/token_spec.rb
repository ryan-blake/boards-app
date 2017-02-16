# == Schema Information
#
# Table name: tokens
#
#  id          :integer          not null, primary key
#  price       :integer
#  item        :string
#  user_id     :integer
#  token       :string
#  customer_id :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Token, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
