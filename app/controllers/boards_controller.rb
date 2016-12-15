class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  # GET /boards
  # GET /boards.json
  def index
    @boardies = Board.order('created_at ASC')
    @boardies = Board.where(:pending => [false]).where(:arrived => [false])
    # make boardies be where board.boolean == false and board.arrived = false
    if current_user.present?
      @on = current_user
      @charge = Charge.where(user_id: @on.id)
    if @charge == nil
      @boards = Board.where(title: @charge.item )
      end
      end
    end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def relist
    @board = Board.find(params[:id])
    @board.arrived = false
    @board.save
  end


  def search
    if params[:value].to_i < 1
      distance_in_miles = 2000
    else
      distance_in_miles = params[:value].to_i
    end
    # casting seems to have changed geocoder locally but works on heroku.

    @boardies = Board.where(:pending => [false]).where(:arrived => [false]).where("cast( type_id as text) like ? and cast( category_id as text) like ? and (title like ? or description like ?)",
            "%#{params[:type_id]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%") \
             .near([request.location.latitude, request.location.longitude], distance_in_miles)
   render :index
 end

 def search_signed_in
   if params[:value].to_i < 1
     distance_in_miles = 2000
   else
     distance_in_miles = params[:value].to_i
   end
   # casting seems to have changed geocoder locally but works on heroku.
   @boardies = Board.where(:pending => [false]).where(:arrived => [false]).where("cast( type_id as text) like ? and cast( category_id as text) like ? and (title like ? or description like ?)",
           "%#{params[:type_id]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%") \
            .near([current_user.latitude, current_user.longitude], distance_in_miles)
  render :index
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:pending, :title, :description, :arrived, :user_id, :price, :lendth, :make, :age, :footgear, :width, :length, :name, :type_id, :category_id, :volume, :address, :city, :state, :zipcode, images_files: [])
    end

end
