# == Schema Information
#
# Table name: conversations
#
#  id           :integer          not null, primary key
#  recipient_id :integer
#  sender_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Conversation < ApplicationRecord
 has_many :messages, dependent: :destroy
 belongs_to :sender, foreign_key: :sender_id, class_name: User
 belongs_to :recipient, foreign_key: :recipient_id, class_name: User

 validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  scope :ordered, -> { joins(:messages).order('messages.updated_at') }


  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

   def opposed_user(user)
     user == recipient ? sender : recipient
   end

   def msg_preview(convo)
      self.messages.where(:conversation_id => convo).last.body
    end
    def msg_sender(convo)
     self.where(:conversation_id => convo).user.name
    end

end
