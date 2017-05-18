  class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy, :create]
helper_method :sort_column, :sort_direction
respond_to :html, :js

# GET /users
# GET /users.json
 def maps
  @user_places = User.where.not(:latitude => nil)
  @url_array = []
     @user_places.each do |user|
       @url_array << (user.id)
   end
 end

def index
  @users = User.all
end

def show
  @user = User.find(params[:id])
  @boards = Board.where(:for_sale => true).order('created_at DESC')
  @boards = Board.where(:for_sale => [true]).where(:user_id => [@user.id], :rental => false).order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
  @boards_M = Board.where(:for_sale => [true]).where(:user_id => [@user.id])
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




 def search_signed_in
   @user = User.find(params[:id])
   @boards = @user.boards.where(:for_sale => true)

   if params[:value].empty?
     distance_in_miles = 3

   else
     distance_in_miles = params[:value]
   end
   if params[:search].empty?
     @boards = Board.where(:for_sale => [true]).where(:user_id => [@user.id]).where("cast( make as text) like ? and cast( category_id as text) like ? and (title like ? or description like ? or make like ?)",

             "%#{params[:make]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
             if params[:rental] == "on"
               @boards =  @boards.where(:rental => true).where("inventory >= ?", 1)
              #  get boards that also havent been rented once unless inventory > 1
              one = @boards
              unless params[:start_date][0].to_s == "" && params[:end_date][0].to_s == ""
                 startDate = Date.parse(params[:start_date].join(', '))
                 endDate = Date.parse(params[:end_date].join(', '))
                 @boards = @boards.start_search(startDate, endDate)
                 @boards = @boards.end_search(startDate, endDate).pluck(:id)
             #  strange behaviour inside scoped starts and stops
              one = one.left_joins(:events).where("board_id IS NULL").pluck(:id)
              @boards = Board.where(:id => (@boards + one))
            else
              one = one.left_joins(:events).where("board_id IS NULL").pluck(:id)
              @boards = Board.where(:id => (one + @boards))
            end
             else
               @boards = @boards.where(:rental => false)
             end
             if (params[:new] == "on") && (params[:used] != params[:new])
                    @boards = @boards.where(:used => true ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(9)
                  elsif (params[:used] == "on") && (params[:used] != params[:new])
                      @boards = @boards.where(:used => false ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(9)
                  else
                       @boards = @boards.reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(9)

                  respond_to do |format|
                         format.js
                     end
                   end

   # casting seems to have changed geocoder locally but works on heroku.
  #  @boardies = Board.where(:for_sale => [true]).where("cast( type_id as text) like ? and cast( category_id as text) like ? and (title like ? or description like ?)",
else
  @boards = Board.where(:for_sale => [true]).where(:user_id => [@user.id]).where("cast( make as text) like ? and cast( category_id as text) like ? and (title like ? or description like ? or make like ?)",

           "%#{params[:make]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%") \
            .near(params[:search], distance_in_miles)
            if params[:rental] == "on"
              @boards =  @boards.where(:rental => true)
            else
              @boards = @boards.where(:rental => false)
            end
            if (params[:new] == "on") && (params[:used] != params[:new])
                         @boards = @boards.where(:used => true ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(9)
                       elsif (params[:used] == "on") && (params[:used] != params[:new])
                           @boards = @boards.where(:used => false ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(9)
                       else
                            @boards = @boards.reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(9)

                       respond_to do |format|
                              format.js
                          end
                        end

  end

end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User
    # @user = User.find(params[:id])
  end
  def sort_column
    Board.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end


  # Never trust parameters from the scary internet, only allow the white list through. update sanitizer for new.
  def user_params
    params.require(:user).permit(:name, :role, :publishable_key, :provider, :uid, :access_code, :email, :address, :city, :state, :zipcode, :latitude, :longitude, :company, :tokens)
  end
end
