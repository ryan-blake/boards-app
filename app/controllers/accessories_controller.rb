class AccessoriesController < ApplicationController
  # before_action :set_accessory, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction, :c_ft ,:c_cm, :c_mm
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

          "%#{params[:kind_id]}%", "%#{params[:brand]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
          # price
          if params[:min][0].to_i >= 1 && params[:max][0].to_i >= 1
            @accessories  = @accessories.min_price(params[:min][0].to_i).max_price(params[:max][0].to_i)
          else
            if params[:max][0].to_i <= 0 && params[:min][0].to_i >= 1
              @accessories  = @accessories.min_price(params[:min][0].to_i).max_price(9999)
            elsif params[:min][0].to_i <= 0 && params[:max][0].to_i >= 1
              @accessories  = @accessories.min_price(1).max_price(params[:max][0].to_i)
            else
              @accessories  = @accessories.min_price(1).max_price(9999)
            end
          end

          #  length / height
          if params[:minimum][0].to_i >= 1 && params[:maximum][0].to_i >= 1
            c = params[:unit_id][0].to_i
            a = params[:minimum][0].to_i
            b = params[:maximum][0].to_i
             unless c == 1
               if c == 2
                 a = c_ft(a)
                 b = c_ft(b)
               elsif c == 3
                 a = c_cm(a)
                 b = c_cm(b)
               else
                 a = c_mm(a)
                 b = c_mm(b)
               end
             end
            @accessories  = @accessories.min_length_search(a).max_length_search(b).limit(40)
          else
            if params[:maximum][0].to_i <= 0 && params[:minimum][0].to_i >= 1
              c = params[:unit_id][0].to_i
              a = params[:minimum][0].to_i
               unless c == 1
                 if c == 2
                   a = c_ft(a)
                 elsif c == 3
                   a = c_cm(a)
                 else
                   a = c_mm(a)
                 end
               end
              @accessories  = @accessories.min_length_search(a).max_length_search(9999).limit(40)
            elsif params[:minimum][0].to_i <= 0 && params[:maximum][0].to_i >= 1
              c = params[:unit_id][0].to_i
              b = params[:maximum][0].to_i
               unless c == 1
                 if c == 2
                   b = c_ft(b)
                 elsif c == 3
                   b = c_cm(b)
                 else
                   b = c_mm(b)
                 end
               end
              @accessories  = @accessories.min_length_search(1).max_length_search(b).limit(40)
            else
              @accessories  = @accessories.min_length_search(0).max_length_search(9999).limit(40)

            end
          end
          @accessories = @accessories.limit(40)
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
  respond_to do |format|
      format.js
    end
end

# GET /accessories/1/edit
def edit

  @accessory = Accessory.find(params[:id])
  if @accessory
  else
    @accessory = Accessory.new
  end

  respond_to do |format|
      format.js
    end

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
        format.js
        format.json { render partial: 'show', status: :created, location: @board }
      else
        format.js { render :new }
        format.json { render new: @accessory.errors, status: :unprocessable_entity }
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

      format.js

    else
      format.js
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

  def c_ft(a)
    a = (a * 12)
  end

  def c_cm(param)

    param = (param / 2.54)

  end
  def c_mm(param)
    param = (param / 25.4)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def accessory_params
    params.require(:accessory).permit(:measured ,:measure, :unit_id, :kind_id, :brand ,:price, :inventory, :color, :title, :type_id, :category_id, :user_id, :board_id,images_files: [], images_attributes: [ :id, :file, :_destroy])
  end

  def set_current_accessories
    @some_accessories = accessory.where board_id: @board.id
    @current_accessories =  @some_accessories.where start_time >= Time.now
  end
end
