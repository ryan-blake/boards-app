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
#  vendor_id  :integer
#  price      :integer
#

class Event < ApplicationRecord
  extend SimpleCalendar
# validate :future_reservations_only, :on => :create
# validates_datetime :end_time, :after => :start_time
validates_date :start_time, :before => :end_time,
                               :before_message => "dates must be in logical order"
belongs_to :vendor, class_name: 'User', foreign_key: 'vendor_id'
belongs_to :user, class_name: 'User', foreign_key: 'user_id'

# validates_time :start_time, :on_or_after => :open_time,
#    :on_or_after_message => 'must be after opening time',
#    :before => :end_time,
#    :before_message => 'must be before close'
# validates_time :end_time, :on_or_after => :open_time,
#    :on_or_after_message => 'must be after opening time',
#    :before => :end_time,
#    :before_message => 'must be before close'

# acts_as_bookable ~> gem if looking to book @boards

# validates :start_time, :end_time, overlap: { scope: 'board_id',
#                                            message_content: 'overlaps with Users other meetings.' }

# validate :unbooked_events, :on => :create
scope :start_search, ->(start) { where('start_time >= ?', start) }
scope :end_search, ->(end_time) { where('end_time <= ?', end_time) }

belongs_to :board


# validates :name, presence: true
# validate all events are paid for first
# def unbooked_events
#   if Event.where(user_id: user, board_id: board, booked: false).length >= 1
#     errors.add(:booked, "Either Cancel or Pay previous reservation.")
#   end
# end

# def future_reservations_only
#   if @event.start_time <= Time.now
#    errors.add(:start_time, "cannot be in the past")
#   end
# end

def parse_time(time_as_string)
  self.start_time = Time.zone.parse(time_as_string)
end

  def load_cost
    a = (((event.end_time - event.start_time) / 86400) * event.board.price).floor
    a =  a * 100
    event.price = a
    event.save!
  end
end
