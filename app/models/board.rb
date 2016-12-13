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
#  arrived     :boolean
#  pending     :boolean
#  address     :string
#  city        :string
#  state       :string
#  zipcode     :integer
#  latitude    :float
#  longitude   :float
#

class Board < ApplicationRecord
  belongs_to :user
  belongs_to :type
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  # mapping

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
