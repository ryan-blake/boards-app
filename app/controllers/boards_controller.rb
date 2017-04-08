class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html, :js

  # GET /boards
  # GET /boards.json
  def index

    @user = current_user
    @boards = Board.where(:for_sale => [true], :rental => false).where(:arrived => [false]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(5)
# end
    @types = Type.order(:name)
    @categories = Category.order(:name)

    if current_user.present?

      @on = current_user
      @charge = Charge.where(user_id: @on.id)
      if @charge == nil
        @boards = Board.where(title: @charge.item )
        @boardies = Board.where(title: @charge.item )
      end
    end
  end

  def remove_image
    @image = Board.find(params[:id]).images
    @image.image.destroy
    redirect_to request.referer
  end

  def boards
    if current_user.present?
      @charge = Charge.where(:user_id => @user.id)
      @my_sales = Charge.where(:vendor_id => @user.id)
    end
  end


  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])
    @user = current_user
    @images= @board.images
    @one = @images.length
    @images = @board.images.page(params[:page]).per(1)
    @event = Event.new
    @charge = Charge.new
    if current_user.present?
      @on = current_user
      @charge = Charge.where(user_id: @on.id)
      if @charge == nil
        @boards = Board.where(title: @charge.item )
        @boardies = Board.where(title: @charge.item )
      end
    end
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
     @user = current_user
     respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
      # BoardMailer.new_board(@board).deliver_now
      @user.tokens += -2
      @user.save
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



 def search_signed_in
   if params[:value].empty?
     distance_in_miles = 3

   else
     distance_in_miles = params[:value]
   end
   if params[:search].empty?
     @boards = Board.where(:for_sale => [true]).where("cast( type_id as text) like ? and cast( category_id as text) like ? and (title like ? or description like ? or make like ?)",

             "%#{params[:type_id]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
             if params[:rental] == "on"
               @boards =  @boards.where(:rental => true)
             else
               @boards = @boards.where(:rental => false)
             end
             if (params[:new] == "on") && (params[:used] != params[:new])
                @boards = @boards.where(:used => true ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(5)
              elsif (params[:used] == "on") && (params[:used] != params[:new])
                  @boards = @boards.where(:used => false ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(5)
              else
                   @boards = @boards.reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(5)

              respond_to do |format|
                     format.js
              end
             end

   # casting seems to have changed geocoder locally but works on heroku.
  #  @boardies = Board.where(:for_sale => [true]).where("cast( type_id as text) like ? and cast( category_id as text) like ? and (title like ? or description like ?)",
else
   @boards = Board.where(:for_sale => [true]).where("cast( type_id as text) like ? and cast( category_id as text) like ? and (title like ? or description like ? or make like ?)",

           "%#{params[:type_id]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%") \
            .near(params[:search], distance_in_miles)
            if params[:rental] == "on"
              @boards =  @boards.where(:rental => true)
            else
              @boards = @boards.where(:rental => false)
            end
            if (params[:new] == "on") && (params[:used] != params[:new])
                         @boards = @boards.where(:used => true ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(5)
                       elsif (params[:used] == "on") && (params[:used] != params[:new])
                           @boards = @boards.where(:used => false ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(5)
                       else
                            @boards = @boards.reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(5)

                       respond_to do |format|
                              format.js
                          end
                        end

end

end




def update_boards
  # @boardies = Board.where("type_id = ?", params[:type_id])
  @boards = Board.where("type_id = ?", params[:type_id])
  respond_to do |format|
    format.js
  end
end

  private
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:tracking, :customer_id, :shipped, :shipping, :for_sale, :pending, :title, :description, :arrived, :user_id, :price, :lendth, :make, :used, :footgear, :width, :length, :name, :type_id, :category_id, :volume, :address,
      :city, :state, :zipcode, images_files: [], images_attributes: [ :id, :file, :_destroy])
    end

end
