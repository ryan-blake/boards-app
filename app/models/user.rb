# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer
#  publishable_key        :string
#  provider               :string
#  uid                    :string
#  access_code            :string
#  stripe_user_id         :string
#  name                   :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  before_save { self.role ||= :member }
  enum role: [:member, :admin]

  has_many :boards, dependent: :destroy
  has_many :paid_charges, class_name: 'Charge', foreign_key: 'user_id', dependent: :destroy
  has_many :received_charges, class_name: 'Charge', foreign_key: 'vendor_id', dependent: :destroy

end
