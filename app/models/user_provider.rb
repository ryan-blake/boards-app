# == Schema Information
#
# Table name: user_providers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserProvider < ApplicationRecord
  belongs_to :user
  def self.find_for_facebook_oauth(auth)

       user = UserProvider.where(:provider => auth.provider, :uid => auth.uid).first
       unless user.nil?
           user.user
       else
           registered_user = User.where(:email => auth.info.email).first
           unless registered_user.nil?
                       UserProvider.create!(
                             provider: auth.provider,
                             uid: auth.uid,
                             user_id: registered_user.id
                             )
               registered_user
           else
               user = User.create!(
                   name: auth.info.name,
                           email: auth.info.email,
                           password: Devise.friendly_token[0,20],
                           )
               user_provider = UserProvider.create!(
                   provider:auth.provider,
                           uid:auth.uid,
                             user_id: user.id
                   )
               user
           end
       end
   end


   
end
