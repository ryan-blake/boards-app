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
#  length      :decimal(5, 2)
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
#  list_time   :datetime         default("2017-06-21 23:06:12")
#  inventory   :integer          default("0")
#  cost        :integer
#  margin      :integer
#  upc         :string
#  company     :string
#

class Board < ApplicationRecord
  belongs_to :user
  belongs_to :type, optional: true
  belongs_to :category
  belongs_to :tail, optional: true
  belongs_to :fin, optional: true
  has_one :size
  accepts_nested_attributes_for :size, allow_destroy: true, reject_if: :all_blank
  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :accessories, dependent: :destroy
  accepts_nested_attributes_for :accessories, allow_destroy: true, reject_if: :non_acc
  has_many :events, dependent: :destroy
  validates_associated :events
  validates :title, :presence => true
  validates :description, :presence => true
  validates :make, :presence => true
  validates :price, :presence => true
  validates :category, :presence => true

  before_validation :load_costs
  after_validation :save_type
  after_save :check_for_tracking_number
  after_update :update_tokens
  after_update :update_margin


  # mapping
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? }

  def non_acc(att)
    att['title'].blank? && new_record?
  end

 scope :min_price, ->(min) { where('price >= ?', min) }
 scope :max_price, ->(max) { where('price <= ?', max) }

 scope :min_length_search, ->(minimum) { where('length >= ?', minimum) }
 scope :max_length_search, ->(maximum) { where('length <= ?', maximum) }

# needs more TESTING
 scope :start_search, -> (startDate, endDate) {
   joins(:events).where.not(:events => {start_time: (startDate.beginning_of_day)..(endDate.end_of_day + 1.days)})
}
scope :end_search, -> (startDate, endDate) {
  joins(:events).where.not(:events => {end_time: (startDate.beginning_of_day)..(endDate.end_of_day)})
}
#
def full_address
  [address, city, state, zipcode].join(', ')
end
  def check_for_tracking_number
    if tracking_changed?
       BoardMailer.tracking_number(self).deliver_now
     end
  end

  def pretty_price
     "$#{price}.00 "
  end

  def sellable?
    self.for_sale && self.inventory >= 1
  end
  def boardSold?
    self.shipping != true || false
  end
  def assignedAccessory?
    if self.accessories.count >= 1
      self.accessories.each do |i|
        "#{i.title} #{i.measure}.#{i.unit.name}. "
      end
    end
  end

  def items?
    "#{title} #{type.name}"
  end

  def surfable?
    self.type_id == 1
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
  def update_margin
   if cost_changed? == true || price_changed? == true
     a =  Board.find(self.id)
     p = a.price.to_f - a.cost.to_f
     r = a.price.to_f
      a.margin = ((p) / (r)) * 100
      a.save
   end
  end
  def load_costs
    if self.cost != nil && self.margin == nil
      r = self.price.to_f
      p = r - self.cost.to_f
      self.margin = ((p) / (r)) * 100
    elsif self.margin != nil && self.price == nil
      c = self.cost.to_f
      m = self.margin.to_f
      r = c / (1 - (m / 100))
      self.price = r.ceil
      self.save
    end
  end

  def save_type
    a = self
    a.type_id = a.category.type_id
  end
  def self.import(file)
    counter = 0
    CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
      board = Board.new(title: row[:title],price: row[:price], margin: row[:margin], cost: row[:cost], user_id: row[:user], category_id: row[:category].to_i, make: row[:make], description: row[:description], length: row[:length], zipcode: row[:zipcode])
        if board.save
          counter += 1
        else
          puts "#{board.user.name} - #{board.errors.full_messages.join(",")}"
        end
    end
    counter
  end

end
