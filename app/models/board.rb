# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  make        :string
#  used        :boolean
#  price       :integer
#  footgear    :boolean
#  user_id     :integer
#  description :string
#  length      :integer
#  title       :string
#  width       :integer
#  type_id     :integer
#  volume      :integer
#  arrived     :boolean          default("f")
#  pending     :boolean          default("f")
#  address     :string
#  city        :string
#  state       :string
#  zipcode     :integer
#  latitude    :float
#  longitude   :float
#  distance_id :integer
#  category_id :integer
#  for_sale    :boolean          default("t")
#  customer_id :string
#  shipping    :boolean
#  shipped     :boolean
#  tracking    :string
#  rental      :boolean          default("f")
#  list_time   :datetime         default("f")
#

class Board < ApplicationRecord
  belongs_to :user
  belongs_to :type, optional: true
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :events
  validates_associated :events

  validates :title, :presence => true
  validates :description, :presence => true
  validates :make, :presence => true
  validates :length, :presence => true
  validates :price, :presence => true
  validates :category, :presence => true
  validates :zipcode, :length => { :is => 5 }
  after_save :check_for_tracking_number
  after_update :update_tokens




  # mapping
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? }

  def full_address
    [address, city, state, zipcode].join(', ')
  end


  def check_for_tracking_number
    if tracking_changed?
       BoardMailer.tracking_number(self).deliver_now
     end
  end

  private

  def update_tokens
    if for_sale_changed? == true
      if self.changes["for_sale"][1]
      a =  Board.find(self.id).user
      a.tokens += -2
      a.save
      end
    end
  end

end
