# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  start_time :datetime
#  end_time   :datetime
#  tag        :string
#  repeat     :string
#  payed      :boolean          default("f")
#  booked     :boolean          default("f")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  board_id   :integer
#  charge_id  :integer
#  name       :string
#  color      :string
#  date_range :string
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
