  class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy, :create]


# GET /users
# GET /users.json
def index
  @users = User.all
end

def show
  @user = User.find(params[:id])
  @boards = Board.where(:for_sale => [true]).where(:user_id => [@user.id])

end

def new
  @user = User.new
end

def edit
  @user = User.find(params[:id])
end

def create
  @user = User.new(user_params)
  respond_to do |format|
    if @user.save
      format.html { redirect_to @user, notice: 'User was successfully created.' }
      format.json { render :show, status: :created, location: @user }
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end


def update
  @user = User.find(params[:id])
  @user.assign_attributes(user_params)
  respond_to do |format|
    if @user.update(user_params)
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
      format.json { render :show, status: :ok, location: @user }
    else
      format.html { render :edit }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @user.destroy
  respond_to do |format|
    format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    format.json { head :no_content }
  end
end


private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User
    # @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through. update sanitizer for new.
  def user_params
    params.require(:user).permit(:name, :role, :publishable_key, :provider, :uid, :access_code, :email, :address, :city, :state, :zipcode, :latitude, :longitude)
  end
end
