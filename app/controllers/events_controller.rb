class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

# GET /events
# GET /events.json
def index
  @events = Event.all
end

# GET /events/1
# GET /events/1.json
def show
  # @board = Spot.find(params[:spot_id])
  # @event = Event.find(params[:id])
  @charge = Charge.new

end

# GET /events/new
def new
  @board = Board.find(params[:board_id])
  @event = Event.new
end

# GET /events/1/edit
def edit
end

# POST /events
# POST /events.json
def create
  @board = Board.find(params[:board_id])
  if current_user
    @user = current_user

  else
    user_email = params[:stripeEmail]

    if User.where(:email => user_email).exists?
      redirect_to new_user_session_path, :notice => "Howdy, Email is already in use, please login or use a different email to complete your purchase." and return


    else
    current_user = User.create!(
    name: user_email,
    email: user_email,
    role: 0,
    password: Faker::Code.asin,
    )


    # current_user.send_reset_password_instructions
    @user = current_user
    @user_new = current_user
    end
  end

  # @charge = Charge.new
  @event = Event.create!(
    board_id: @board.id,
    start_time:  params['daterange'].split(' - ').first,
    end_time:  params['daterange'].split(' - ').last,
    user_id: @user.id,
    vendor_id: @board.user.id,
    name: @user.email
  )
    charge_error = nil

 days = ((@event.end_time - @event.start_time) / 86400) + 1
    if @event.valid?

      begin
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :card  => params[:stripeToken])

          @charge = Charge.new(
          price: ((days * @board.price) * 100),
            user_id: @user.id,
            vendor_id: @board.user_id,
            item: @board.title,
            token: params[:stripeToken],
            customer_id: customer.id,
            completed: false,
            board_id: @board.id,
            start_time: @event.start_time,
            end_time: @event.end_time,
            rental:  true
          )

      rescue Stripe::CardError => e
        @event.destroy
        charge_error = e.message

      end

      if charge_error
        @event.destroy
        flash[:error] = charge_error
        render :new
      else
        @charge.save
        if @charge
          Stripe.api_key = ENV["STRIPE_API_KEY"]
          token = params[:stripeToken]
          charge = Stripe::Charge.create({
            :amount => @charge.price,
            :description => 'Rails Stripe customer',
            :customer => @charge.customer_id,
            :currency => 'usd',
            :destination => @charge.vendor.stripe_account,
            :application_fee => 200+(@charge.price*3)+ 31
            },
          )

          @charge.update_attribute(:completed, true)
          @board.inventory += -1
          @board.save
          @event.total = @charge.price
          @event.charge_id = @charge.id
          @event.save

          redirect_to dash_path, flash: {notice: "Charge Successful"}
        end

      end
    else
      flash[:error] = 'one or more errors in your order'
      render :new
    end
if @user_new != nil
  @user_new.send_reset_password_instructions
end


end

# PATCH/PUT /events/1
# PATCH/PUT /events/1.json
def update
  respond_to do |format|
    if @event.update(event_params)
      format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      format.json { render :show, status: :ok, location: @event }
    else
      format.html { render :edit }
      format.json { render json: @event.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /events/1
# DELETE /events/1.json
def destroy
  @event.destroy
  respond_to do |format|
    format.html { redirect_to :back, notice: 'Reservation successfully cancelled.' }
    format.json { head :no_content }
  end
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :start_time, :end_time, :booked, :payed)
  end

  def set_current_events
  @some_events = Event.where board_id: @board.id
  @current_events =  @some_events.where start_time >= Time.now

  end
end
