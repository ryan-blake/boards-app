class AccessoriesController < ApplicationController
  # before_action :set_accessory, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html, :js


# GET /accessories
# GET /accessories.json
def index
  @accessories = accessory.all
end
def table
  @accessories = Accessory.all.order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
end

def search_table

  @accessories = Accessory.where(user_id: current_user.id).where("cast( kind_id as text) like ? and cast( brand as text) like ? and cast( category_id as text) like ? and (title like ? or color like ? or brand like ?)",

          "%#{params[:kind_id]}%", "%#{params[:brand]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
          @acc_array = []
             @accessories.each do |a|
               @acc_array << (a.price)
           end

end

def search_accessories
  @board = Board.find(params[:board_id])
    @accessories = Accessory.where(board_id: nil, user_id: @board.user.id, category_id: @board.category_id).where("cast( kind_id as text) like ? and cast( brand as text) like ? and (title like ? or color like ? or brand like ?)",

          "%#{params[:kind_id]}%", "%#{params[:brand]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").limit(40)
end



# GET /accessories/1
# GET /accessories/1.json
def show
  # @board = Spot.find(params[:spot_id])
  # @accessory = accessory.find(params[:id])

  @accessory = Accessory.find(params[:id])
  if @accessory.board
    @board = @accessory.board
  end

end

# GET /accessories/new
def new
  # @board = Board.find(params[:board_id])
  @accessory = Accessory.new
end
def inventory
  @accessory = Accessory.new

end

# GET /accessories/1/edit
def edit
  @accessory = Accessory.find(params[:id])
end

# POST /accessories
# POST /accessories.json
def create
  # @board = Board.find(params[:board_id])
  @accessory = Accessory.new(accessory_params)
  if current_user
    @user = current_user
    respond_to do |format|
     if @accessory.save
       format.html { redirect_to dash_path, notice: 'Board was successfully created.' }
       format.json { render :show, status: :created, location: @accessory }
     else
       format.html { render :inventory }
       format.json { render json: @accessory.errors, status: :unprocessable_entity }
     end
   end

  end

end

# PATCH/PUT /accessories/1
# PATCH/PUT /accessories/1.json
def update
  @accessory = Accessory.find_by(params[:id])
  respond_to do |format|
    if @accessory.update(accessory_params)
      format.html { redirect_to @accessory, notice: 'accessory was successfully updated.' }
      format.json { render :show, status: :ok, location: @accessory }
    else
      format.html { render :edit }
      format.json { render json: @accessory.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /accessories/1
# DELETE /accessories/1.json
def destroy
  @accessory.destroy
  respond_to do |format|
    format.html { redirect_to :back, notice: 'Reservation successfully cancelled.' }
    format.json { head :no_content }
  end
end

private

def sort_column
  Accessory.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
end

def sort_updated
  Accessory.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
end
  # Use callbacks to share common setup or constraints between actions.
  def set_accessory
    @accessory = accessory.find(params[:accessory_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def accessory_params
    params.require(:accessory).permit(:kind_id, :brand ,:price, :inventory, :color, :title, :type_id, :category_id, :user_id, :board_id,images_files: [], images_attributes: [ :id, :file, :_destroy])
  end

  def set_current_accessories
    @some_accessories = accessory.where board_id: @board.id
    @current_accessories =  @some_accessories.where start_time >= Time.now
  end
end
