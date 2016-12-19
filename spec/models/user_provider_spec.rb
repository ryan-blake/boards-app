# == Schema Information
#
# Table name: user_providers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserProvider, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
