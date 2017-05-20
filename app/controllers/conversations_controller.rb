class ConversationsController < ApplicationController
  def create
   @conversation = Conversation.get(current_user.id, params[:user_id])

   add_to_conversations unless conversated?

   respond_to do |format|
     format.js
   end
  end
def msg
  @user = current_user
  @users = User.all.where.not(id: current_user)
  @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
end
  def close
   @conversation = Conversation.find(params[:id])

   session[:conversations].delete(@conversation.id)

   respond_to do |format|
     format.js
   end
 end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end

end
