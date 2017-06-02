class ConversationsController < ApplicationController
  def create
   @conversation = Conversation.get(current_user.id, params[:user_id])
   add_to_conversations unless conversated?

   respond_to do |format|
     format.js
   end
  end

def msg
  @user = User.where(id: 1).first
  @users = User.all.where.not(id: current_user)
  if @user.conversations || Conversation.where(recipient_id: @user.id)
    @conversations = Conversation.where(:recipient_id => @user.id).pluck(:id)
    @conversations_started = Conversation.where(:sender_id => @user.id).pluck(:id)
    @conversations = @conversations << @conversations_started
    @conversations = Conversation.where(:id => @conversations)
  end
  @user_places = User.where.not(:latitude => nil)
  @url_array = []
     @user_places.each do |user|
       @url_array << (user.id)
   end
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
