class ConversationMailer < ApplicationMailer

  def new_message(conversation)
    @conversation = conversation
    @sender = Conversation.where(:id => conversation.conversation_id).first
    @sender = @sender.opposed_user(conversation.user)
    @deliver = []
    @deliver.push(@sender)
    mail to: @sender.email, subject: "new message #{@conversation.body.truncate(15)}"
  end

  private

end
