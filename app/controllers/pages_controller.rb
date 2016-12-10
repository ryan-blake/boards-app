class PagesController < ApplicationController
  def list
    @users = User.all
    @boards = Board.all
    @charge  = Charge.new

  end

  def boards
    @user = current_user
    @charge = Charge.where(user_id: @user)
    if @user && @charge
        @boards = Board.find_by(title: @charge )
    end
  end
end
