# == Schema Information
#
# Table name: accessories
#
#  id         :integer          not null, primary key
#  name       :string
#  brand      :string
#  color      :string
#  price      :integer
#  inventory  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Accessory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
