# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer
#  publishable_key        :string
#  provider               :string
#  uid                    :string
#  access_code            :string
#  stripe_user_id         :string
#  address                :string
#  city                   :string
#  state                  :string
#  zipcode                :integer
#  latitude               :float
#  longitude              :float
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :stripe_connect]
  before_save { self.role ||= :member }
  validates :zipcode, :length => { :is => 5 }
  validates :state, :length => { :is => 2 }
  validates :name, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :name, :presence => true
  validates :email, :presence => true


  enum role: [:member, :admin]

  has_many :boards, dependent: :destroy
  has_many :paid_charges, class_name: 'Charge', foreign_key: 'user_id', dependent: :destroy
  has_many :received_charges, class_name: 'Charge', foreign_key: 'vendor_id', dependent: :destroy
  has_many :user_provider, :dependent => :destroy

  # mapping

  # mapping
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? }

  def full_address
    [address, city, state, zipcode].join(', ')
  end



end
