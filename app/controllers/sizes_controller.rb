class SizesController < ApplicationController
    # before_action :set_size, only: [:show, :edit, :update, :destroy]
    helper_method :sort_column, :sort_direction
    respond_to :html, :js


  # GET /accessories
  # GET /accessories.json
  def index
    @accessories = size.all
  end
  # def table
  #   @accessories = Size.all.order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
  # end
  #
  # def search_table
  #
  #   @accessories = Size.where(user_id: current_user.id).where("cast( kind_id as text) like ? and cast( brand as text) like ? and cast( category_id as text) like ? and (title like ? or color like ? or brand like ?)",
  #
  #           "%#{params[:kind_id]}%", "%#{params[:brand]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
  #           @acc_array = []
  #              @accessories.each do |a|
  #                @acc_array << (a.price)
  #            end
  #
  # end
  #
  # def search_board
  #   @board = Board.find(params[:board_id])
  #     @accessories = Size.where(board_id: nil, user_id: @board.user.id, category_id: @board.category_id).where("cast( kind_id as text) like ? and cast( brand as text) like ? and (title like ? or color like ? or brand like ?)",
  #
  #           "%#{params[:kind_id]}%", "%#{params[:brand]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").limit(40)
  # end
  #


  # GET /accessories/1
  # GET /accessories/1.json
  def show
    # @board = Spot.find(params[:spot_id])
    # @size = size.find(params[:id])
    @board = Board.find(params[:id])
    @size = @board.size

  end

  # GET /accessories/new
  def new
    # @board = Board.find(params[:board_id])
    @size = Size.new
  end


  # GET /accessories/1/edit
  def edit
    @size = Size.find(params[:id])
  end

  # POST /accessories
  # POST /accessories.json
  def create
    # @board = Board.find(params[:board_id])
    @size = Size.new(size_params)
    if current_user
      @user = current_user
      respond_to do |format|
       if @size.save
         format.html { redirect_to dash_path, notice: 'Board was successfully created.' }
         format.json { render :show, status: :created, location: @size }
       else
         format.html { render :inventory }
         format.json { render json: @size.errors, status: :unprocessable_entity }
       end
     end

    end

  end

  # PATCH/PUT /accessories/1
  # PATCH/PUT /accessories/1.json
  def update
    @size = Size.find_by(params[:id])
    respond_to do |format|
      if @size.update(size_params)
        format.html { redirect_to @size, notice: 'size was successfully updated.' }
        format.json { render :show, status: :ok, location: @size }
      else
        format.html { render :edit }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accessories/1
  # DELETE /accessories/1.json
  def destroy
    @size.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Reservation successfully cancelled.' }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    Size.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_updated
    Size.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_size
      @size = size.find(params[:size_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def size_params
      params.require(:size).permit(:kind_id, :unit_id,:length, :width, :feet, :inches , :category_id, :board_id, images_files: [], images_attributes: [ :id, :file, :_destroy])
    end

    def set_current_accessories
      @some_accessories = size.where board_id: @board.id
      @current_accessories =  @some_accessories.where start_time >= Time.now
    end
end
