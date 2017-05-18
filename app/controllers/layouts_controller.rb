
class LayoutsController < ApplicationController
  def messageDash
    @user = current_user
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
    .find(session[:conversations])


    respond_to do |format|
      format.html
      format.js

    end
  end


end
