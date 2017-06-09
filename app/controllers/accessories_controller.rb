class AccessoriesController < ApplicationController
  before_action :set_accessory, only: [:show, :edit, :update, :destroy]

# GET /accessories
# GET /accessories.json
def index
  @accessories = accessory.all
end
def table
  @accessories = Accessory.all.page(params[:page]).per(4)
end

# GET /accessories/1
# GET /accessories/1.json
def show
  # @board = Spot.find(params[:spot_id])
  # @accessory = accessory.find(params[:id])

  @accessory = Accessory.find(params[:accessory_id])

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
  @board = Board.find(params[:board_id])
  @accessory = Accessory.new
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
 #  else
 #    user_email = params[:stripeEmail]
 #
 #    if User.where(:email => user_email).exists?
 #      redirect_to new_user_session_path, :notice => "Howdy, Email is already in use, please login or use a different email to complete your purchase." and return
 #
 #    else
 #    current_user = User.create!(
 #    name: user_email,
 #    email: user_email,
 #    role: 0,
 #    password: Faker::Code.asin,
 #    )
 #
 #
 #    # current_user.send_reset_password_instructions
 #    @user = current_user
 #    @user_new = current_user
 #    end
 #  end
 #
 #  # @charge = Charge.new
 #  @accessory = accessory.create!(
 #    board_id: @board.id,
 #    start_time:  params['daterange'].split(' - ').first,
 #    end_time:  params['daterange'].split(' - ').last,
 #    user_id: @user.id,
 #    vendor_id: @board.user.id,
 #    name: @user.email
 #  )
 #    charge_error = nil
 #
 # days = ((@accessory.end_time - @accessory.start_time) / 86400) + 1
 #    if @accessory.valid?
 #
 #      begin
 #        customer = Stripe::Customer.create(
 #          :email => params[:stripeEmail],
 #          :card  => params[:stripeToken])
 #
 #          @charge = Charge.new(
 #          price: ((days * @board.price) * 100),
 #            user_id: @user.id,
 #            vendor_id: @board.user_id,
 #            item: @board.title,
 #            token: params[:stripeToken],
 #            customer_id: customer.id,
 #            completed: false,
 #            board_id: @board.id,
 #            start_time: @accessory.start_time,
 #            end_time: @accessory.end_time,
 #            rental:  true
 #          )
 #
 #      rescue Stripe::CardError => e
 #        @accessory.destroy
 #        charge_error = e.message
 #
 #      end
 #
 #      if charge_error
 #        @accessory.destroy
 #        flash[:error] = charge_error
 #        render :new
 #      else
 #        @charge.save
 #        if @charge
 #          Stripe.api_key = ENV["STRIPE_API_KEY"]
 #          token = params[:stripeToken]
 #          charge = Stripe::Charge.create({
 #            :amount => @charge.price,
 #            :description => 'Rails Stripe customer',
 #            :customer => @charge.customer_id,
 #            :currency => 'usd',
 #            :destination => @charge.vendor.stripe_account,
 #            :application_fee => 200+(@charge.price*3)+ 31,
 #            metadata: { "shipping" => @charge.shipping,
 #              "charge_id" => @charge.id,
 #               "board" => @board.title,
 #               "vendor" => User.find(@charge.vendor_id).name,
 #               "vendor_id" => User.find(@charge.vendor_id).id,
 #                "customer" => User.find(@charge.user_id).name,
 #                "customer_id" => User.find(@charge.user_id).id,
 #                "rental" => true }
 #
 #            },
 #          )
 #          @charge.charge_stripe = charge['id']
 #          @charge.update_attribute(:completed, true)
 #          @charge.save
 #          @board.inventory += -1
 #          @board.save
 #          @accessory.total = @charge.price
 #          @accessory.charge_id = @charge.id
 #          @accessory.save
 #
 #          redirect_to dash_path, flash: {notice: "Charge Successful"}
 #        end
 #
 #      end
    # else
    #   flash[:error] = 'one or more errors in your order'
    #   render :new
    # end
# if @user_new != nil
#   @user_new.send_reset_password_instructions
  end

end

# PATCH/PUT /accessories/1
# PATCH/PUT /accessories/1.json
def update
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
  # Use callbacks to share common setup or constraints between actions.
  def set_accessory
    @accessory = accessory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def accessory_params
    params.require(:accessory).permit(:brand ,:price, :inventory, :color, :title, :type_id, :category_id, :user_id, :board_id,images_files: [], images_attributes: [ :id, :file, :_destroy])
  end

  def set_current_accessories
    @some_accessories = accessory.where board_id: @board.id
    @current_accessories =  @some_accessories.where start_time >= Time.now
  end
end
