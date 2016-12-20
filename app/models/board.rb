# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  make        :string
#  age         :integer
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
#

class Board < ApplicationRecord
  belongs_to :user
  belongs_to :type
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :make, :presence => true
  validates :length, :presence => true
  validates :price, :presence => true
  validates :type, :presence => true
  validates :category, :presence => true
  validates :zipcode, :length => { :is => 5 }



  # mapping
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? }

  def full_address
    [address, city, state, zipcode].join(', ')
  end


  def lengths
    @lengths = []

    @boards.each do |i|
      @lengths.push(i.length)
    end
    puts @lenghts.uniq!
  end
end
