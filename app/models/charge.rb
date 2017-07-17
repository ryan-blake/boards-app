# == Schema Information
#, "CountryCode"=>"US", "Zip"=>"24224", "stripeShippingAddressLine1"=>"tha street", "City"=>"o4j", "State"=>"VA"}

# Table name: charges
#
#  id            :integer          not null, primary key
#  price         :integer
#  item          :string
#  user_id       :integer
#  vendor_id     :integer
#  token         :string
#  customer_id   :string
#  completed     :boolean          default("f")
#  boolean       :boolean          default("f")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  board_id      :string
#  address       :string
#  shipping      :boolean
#  start_time    :datetime
#  end_time      :datetime
#  rental        :boolean
#  charge_stripe :string
#  accessories   :string
#  picked        :string
#  shipped       :string
#

class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :board
  belongs_to :vendor, class_name: 'User', foreign_key: 'vendor_id'


  def rent_time(board)
    board.end_time - board.start_time
  end

  def chargeBoard
    Board.find(self.board_id)
  end

  def non_acc(att)
    att['title'].blank? && new_record?
  end

  def receipts(charges)
   @receipts = Charge.where(id: charges)
  end
end
