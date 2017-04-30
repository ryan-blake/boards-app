class AccessoriesController < ApplicationController
    before_action :set_accessory, only: [:show, :edit, :update, :destroy]

  # GET /accessories
  # GET /accessories.json
  def index
    @accessories = Accessory.all
  end

  # GET /accessories/1
  # GET /accessories/1.json
  def show
    # @board = Spot.find(params[:spot_id])
    # @Accessory = Accessory.find(params[:id])
    @accessories = Accessory.all

  end

  # GET /accessories/new
  def new
    @board = Board.find(params[:board_id])
    @Accessory = Accessory.new
  end

  # GET /accessories/1/edit
  def edit
  end

  # POST /accessories
  # POST /accessories.json
  def create



    # @unbooked = Accessory.where(user_id: @user.id, board_id: @board.id, booked: false)


  end

  # PATCH/PUT /accessories/1
  # PATCH/PUT /accessories/1.json
  def update
    respond_to do |format|
      if @Accessory.update(Accessory_params)
        format.html { redirect_to @Accessory, notice: 'Accessory was successfully updated.' }
        format.json { render :show, status: :ok, location: @Accessory }
      else
        format.html { render :edit }
        format.json { render json: @Accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accessories/1
  # DELETE /accessories/1.json
  def destroy
    @Accessory.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Reservation successfully cancelled.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accessory
      @Accessory = Accessory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accessory_params
      params.require(:Accessory).permit(:name, :start_time, :end_time, :booked, :payed)
    end

    def set_current_accessories
    @some_accessories = Accessory.where board_id: @board.id
    @current_accessories =  @some_accessories.where start_time >= Time.now

    end
  end

end
