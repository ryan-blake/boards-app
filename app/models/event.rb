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
#

class Event < ApplicationRecord
  extend SimpleCalendar
validate :future_reservations_only, :on => :create
validates_datetime :end_time, :after => :start_time
validates :start_time, :end_time, overlap: { scope: 'board_id',
                                           message_content: 'overlaps with Users other meetings.' }

validate :unbooked_events, :on => :create
belongs_to :user
belongs_to :board

# validates :name, presence: true
def unbooked_events
  if Event.where(user_id: user, board_id: board, booked: false).length >= 1
    errors.add(:booked, "Either Cancel or Pay previous reservation.")
  end
end

def future_reservations_only
  if start_time < Time.now
   errors.add(:start_time, "cannot be in the past")
  end
end
