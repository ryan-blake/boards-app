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

require 'rails_helper'

RSpec.describe Kind, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end