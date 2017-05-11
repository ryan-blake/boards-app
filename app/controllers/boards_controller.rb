class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html, :js

  # GET /boards
  # GET /boards.json
  def index
      @user = current_user
      # @boards = Board.find_by(user_id: @user)
      @boardies = Board.find_by(user_id: @user)
      @charge = Charge.where(user_id: @user)
      if @user && @charge
          @boardies = Board.where(title: @charge )
      end
      session[:conversations] ||= []
      @users = User.all.where.not(id: current_user)
      @conversations = Conversation.includes(:recipient, :messages)
        .find(session[:conversations])

      @user = current_user
      @boards = Board.where(:for_sale => [true], :rental => false).where(:arrived => [false]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
  # end
      @types = Type.order(:name)
      @categories = Category.order(:name)

  end


  def board_dash
    if current_user
      @user = current_user
      @shipping_boards = Board.where(user_id: current_user.id, for_sale: false, shipping: true).order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
      @pickup_boards = Board.where(user_id: current_user.id, for_sale: false, shipping: false).order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
      session[:conversations] ||= []
      @users = User.all.where.not(id: current_user)
      @conversations = Conversation.includes(:recipient, :messages)
      .find(session[:conversations])

      # stripe account data
      if current_user.stripe_account
        @stripe_account = Stripe::Account.retrieve(current_user.stripe_account)

        @payments = Stripe::Charge.list(
        {
          limit: 100,
          expand: ['data.source_transfer', 'data.application_fee']
        },
        { stripe_account: current_user.stripe_account }
        )

        @transfers = Stripe::Transfer.list(
          {
            limit: 100
          },
          { stripe_account: current_user.stripe_account }
        )

        @balance = Stripe::Balance.retrieve(stripe_account: current_user.stripe_account)

    # Retrieve transactions with an available_on date in the future
    transactions = Stripe::BalanceTransaction.all(
      {
        limit: 100,
        available_on: {gte: Time.now.to_i}
      },{ stripe_account: current_user.stripe_account })

    balances = Hash.new

    # Iterate through transactions and sum values for each available_on date
    transactions.auto_paging_each do |txn|
      if balances.key?(txn.available_on)
        balances[txn.available_on] += txn.net
      else
        balances[txn.available_on] = txn.net
      end
    end


    # Sort the results
    @transactions = balances.sort_by {|date,net| date}

    # end new data from connect
    end
    else
      redirect_to root_path
    end
  end
  def active_boards
    @user = current_user
    @active_boards = Board.where(user_id: current_user.id, pending: nil || false, for_sale: true, pending: false).order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
  end
  def inactive_boards
    @user = current_user
    @inactive_boards = Board.where(user_id: current_user.id, pending: nil || false, for_sale: false).order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
  end
  def shipped_boards
    @user = current_user
    @shipping_boards = Board.where(user_id: current_user.id, for_sale: false, shipping: true).order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
  end
  def pending_boards
    @user = current_user
      @on = current_user
      @charge = Charge.where(user_id: @user.id, completed: false)
      if @charge == nil
        @boards = Board.where(title: @charge.item )
        @boardies = Board.where(title: @charge.item )
      end

      @charge.each do |i|
        @pending_boards = Board.where(title: i.item, for_sale: false, id: i.board_id, :pending => true)

      end
      if @pending_boards
      @pending_boards = @pending_boards.order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
    end
  end
  def pick_boards
    @user = current_user
     @pickup_boards = Board.where(user_id: current_user.id, for_sale: false, shipping: false).order(sort_column + ' ' + sort_direction).page(params[:page]).per(4)
  end
  def sales_boards
   @sales_user = current_user.name

       @payments = Stripe::Charge.list(
         {
           limit: 100,
           expand: ['data.source_transfer', 'data.application_fee']
         },
         { stripe_account: current_user.stripe_account }
       )
       @transfers = Stripe::Transfer.list(
  {
    limit: 100
  },
  { stripe_account: current_user.stripe_account }
)

       @balance = Stripe::Balance.retrieve(stripe_account: current_user.stripe_account)
       # Retrieve transactions with an available_on date in the future
transactions = Stripe::BalanceTransaction.all(
  {
    limit: 100,
    available_on: {gte: Time.now.to_i}
  },{ stripe_account: current_user.stripe_account })

       balances = Hash.new

             # Iterate through transactions and sum values for each available_on date
             transactions.auto_paging_each do |txn|
               if balances.key?(txn.available_on)
                 balances[txn.available_on] += txn.net
               else
                 balances[txn.available_on] = txn.net
               end
             end

       @transactions = balances.sort_by {|date,net| date}


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
    respond_to do |format|
        format.js
      end
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

        format.js

      else
        format.js
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
     @boards = Board.where(:for_sale => [true]).where("cast( make as text) like ? and cast( category_id as text) like ? and (title like ? or description like ? or make like ?)",

             "%#{params[:make]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
             # price

#
            if params[:min][0].to_i >= 1 && params[:max][0].to_i >= 1
                @boards  = @boards.min_price(params[:min][0].to_i).max_price(params[:max][0].to_i)
              else
                if params[:max][0].to_i == 0
                  @boards  = @boards.min_price(1).max_price(9999)
                else
                @boards  = @boards.min_price(1).max_price(params[:max][0].to_i)
              end
            end
#
             #  length / height
             if params[:minimum][0].to_i >= 1 && params[:maximum][0].to_i >= 1
               @boards  = @boards.min_length_search(params[:minimum][0].to_i).max_length_search(params[:maximum][0].to_i)
             else
               if params[:maximum][0].to_i == 0 && params[:maximum][0].to_i >= 1
                 @boards  = @boards.min_length_search(params[:minimum][0].to_i).max_length_search(9999)
               elsif params[:minimum][0].to_i == 0 && params[:maximum][0].to_i >= 1
                 @boards  = @boards.min_length_search(1).max_length_search(params[:maximum][0].to_i)
               else
                 @boards  = @boards.min_length_search(1).max_length_search(9999)
               end
             end

             if params[:rental] == "on"
               @boards =  @boards.where(:rental => true)
             else
               @boards = @boards.where(:rental => false)
             end
             if (params[:new] == "on") && (params[:used] != params[:new])
                @boards = @boards.where(:used => true ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
              elsif (params[:used] == "on") && (params[:used] != params[:new])
                  @boards = @boards.where(:used => false ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
              else

                   @boards = @boards.reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(8)

              respond_to do |format|
                     format.js
              end
             end

   # casting seems to have changed geocoder locally but works on heroku.
  #  @boardies = Board.where(:for_sale => [true]).where("cast( type_id as text) like ? and cast( category_id as text) like ? and (title like ? or description like ?)",

else
   @boards = Board.where(:for_sale => [true]).where("cast( make as text) like ? and cast( category_id as text) like ? and (title like ? or description like ? or make like ?)",

           "%#{params[:make]}%", "%#{params[:category_id]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%") \
            .near(params[:search], distance_in_miles)
            # price
            #
              if params[:min][0].to_i >= 1 && params[:max][0].to_i >= 1
                @boards  = @boards.min_price(params[:min][0].to_i).max_price(params[:max][0].to_i)
              else
                if params[:max][0].to_i == 0
                  @boards  = @boards.min_price(1).max_length_search(9999)
                else
                @boards  = @boards.min_price(1).max_price(params[:max][0].to_i)
              end
              end
            #

           #  length / height
           if params[:minimum][0].to_i >= 1 && params[:maximum][0].to_i >= 1
             @boards  = @boards.min_length_search(params[:minimum][0].to_i).max_length_search(params[:maximum][0].to_i)
           else
             if params[:maximum][0].to_i == 0
               @boards  = @boards.min_length_search(1).max_length_search(9999)
             else
             @boards  = @boards.min_length_search(1).max_length_search(params[:maximum][0].to_i)
           end
           end


            if params[:rental] == "on"
              @boards =  @boards.where(:rental => true)
            else
              @boards = @boards.where(:rental => false)
            end
            if (params[:new] == "on") && (params[:used] != params[:new])
                         @boards = @boards.where(:used => true ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
                       elsif (params[:used] == "on") && (params[:used] != params[:new])
                           @boards = @boards.where(:used => false ).reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
                       else
                            @boards = @boards.reorder(sort_column + ' ' + sort_direction).page(params[:page]).per(8)

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

  def sort_updated
    Board.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
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
      params.require(:board).permit(:tracking, :customer_id, :shipped, :shipping, :for_sale, :pending, :title, :description, :arrived, :user_id, :price, :lendth, :make, :used, :footgear, :width, :length, :name, :type_id, :category_id, :list_time, :volume, :address,
      :city, :state, :remote_image_url,:zipcode, images_files: [], images_attributes: [ :id, :file, :_destroy])
    end

end
