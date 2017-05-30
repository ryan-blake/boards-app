class PagesController < ApplicationController
  def list
    @users = User.all
    # @boards = Board.all
    @boardies = Board.all
    @charge  = Charge.new
  end



  def boards
    if current_user
      @user = current_user
      @active_boards = Board.where(user_id: current_user.id, pending: nil || false, for_sale: true).page(params[:page]).per(8)
      @inactive_boards = Board.where(user_id: current_user.id, pending: nil || false, for_sale: false)
      @shipping_boards = Board.where(user_id: current_user.id, for_sale: false, shipping: true)
      @pickup_boards = Board.where(user_id: current_user.id, for_sale: false, shipping: false)

    # @boards = Board.find_by(user_id: @user)
    @boardies = Board.find_by(user_id: @user)
    @charge = Charge.where(user_id: @user)
    if @user && @charge
        @boardies = Board.where(title: @charge )
    end
    session[:conversations] ||= []
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
      .find(session[:conversations])
    else
      redirect_to root_path
  end
 end
end
