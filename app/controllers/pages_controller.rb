class PagesController < ApplicationController
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
  end
end
