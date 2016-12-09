# == Schema Information
#
# Table name: charges
#
#  id             :integer          not null, primary key
#  item           :string
#  price          :integer
#  user_id        :integer
#  vendor_id      :integer
#  token          :string
#  customer_id    :string
#  completed      :boolean
#  stripe_user_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :vendor, class_name: 'User', foreign_key: 'vendor_id'
end
