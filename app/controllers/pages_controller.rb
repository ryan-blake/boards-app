class PagesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def list
    @users = User.all
    # @boards = Board.all
    @boardies = Board.all
    @charge  = Charge.new
  end

  def boards


    

    @user = current_user
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
  end

private

  def sort_column
    Board.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
end
