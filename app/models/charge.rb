# == Schema Information
#
# Table name: charges
#
#  id            :integer          not null, primary key
#  item          :string
#  user_id       :integer
#  vendor_id     :integer
#  token         :string
#  customer_id   :string
#  completed     :boolean          default("f")
#  boolean       :boolean          default("f")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  board_id      :integer
#  address       :string
#  shipping      :boolean
#  start_time    :datetime
#  end_time      :datetime
#  rental        :boolean
#  charge_stripe :string
#  accessories   :string
#  picked        :string
#  shipped       :string
#  zipcode       :string
#  country       :string
#  state         :string
#  city          :string
#  tracking      :string
#  price         :decimal(8, 2)
#

class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :board
  belongs_to :vendor, class_name: 'User', foreign_key: 'vendor_id'
  after_save :check_for_tracking_number


  def full_address
    [address, city, state, zipcode].join(', ')
  end

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

  def check_for_tracking_number
    if tracking_changed?
       ChargeMailer.tracking_number(self).deliver_now
     end
  end
end
