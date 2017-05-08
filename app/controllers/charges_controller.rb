class ChargesController < ApplicationController

  def new
    # Stripe::Charge.all(
    #  { customer: stripe_id },
    #  stripe_account: connected_account_id).data
  end

  def create

  if current_user
  customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
    :card => params[:stripeToken]
  )

  @charge = Charge.new(
    price: params[:charge]["amount"].to_i,
    user_id: current_user.id,
    vendor_id: params[:charge]["owner_id"].to_i,
    item: params[:charge]["item"],
    token: params[:stripeToken],
    customer_id: customer.id,
    completed: false,
    board_id: params[:charge]["board_id"],
    shipping: params[:charge]["shipping"]
  )


  @charge.update_attribute(:boolean, true)
  @charge.save
  @board = Board.where(id: @charge.board_id).first
  @board.shipping = params[:charge]["shipping"]
  @board.update_attribute(:arrived, false)
  @board.customer_id = current_user.id
  @board.update_attribute(:pending, true)
  @board.for_sale = false
  @board.save
  redirect_to  root_path


  # ChargeMailer.new_charge_user(@charge).deliver_now
  # ChargeMailer.new_charge_vendor(@charge).deliver_now

    else !current_user
      user_email = params[:stripeEmail]

      if User.where(:email => user_email).exists?
        redirect_to new_user_session_path , :notice => "Howdy, Email is already in use, please login or use a different email to complete your purchase."
      else
      current_user = User.create!(
      name: user_email,
      email: user_email,
      role: 0,
      password: Faker::Code.asin,
    )
    current_user.send_reset_password_instructions

    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
      :card => params[:stripeToken]
    )

    @charge = Charge.new(
      price: params[:charge]["amount"].to_i,
      user_id: current_user.id,
      vendor_id: params[:charge]["owner_id"].to_i,
      item: params[:charge]["item"],
      token: params[:stripeToken],
      customer_id: customer.id,
      completed: false,
      board_id: params[:charge]["board_id"],
      shipping: params[:charge]["shipping"]
    )

    @charge.update_attribute(:boolean, true)
    @charge.save
    @board = Board.where(id: @charge.board_id).first
    @board.update_attribute(:arrived, false)
    @board.shipping = params[:charge]["shipping"]
    @board.customer_id = current_user.id
    @board.update_attribute(:pending, true)
    @board.for_sale = false
    @board.save

    # ChargeMailer.new_charge_user(@charge).deliver_now
    # ChargeMailer.new_charge_vendor(@charge).deliver_now

      redirect_to new_user_session_path, :notice => "HOWDY, Your board is ordered! Check your email to create your password and confirm your email."
   end
 end
end

  def complete
    @charge = Charge.find(params[:charge_id])
     @board = Board.find_by(id: @charge.board_id,  arrived: false)

    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:token]
    charge = Stripe::Charge.create({
      :amount => @charge.price*100,
      :description => 'Rails Stripe customer',
      :customer => params[:customer_id],
      :currency => 'usd',
      :destination => @charge.vendor.stripe_account,
      :application_fee => 200+(@charge.price*3)+ 31,
       metadata: { "shipping" => params[:shipping], "board" => @board.title, "customer" => User.find(params[:customer_id]).name }
     },
    )
    @charge.update_attribute(:completed, true)
    @board.update_attribute(:arrived, true)
    @board.user_id = @charge.user_id
    @board.update_attribute(:shipping, nil)
    @board.update_attribute(:shipped, nil)
    @board.update_attribute(:customer_id, nil)
    @board.update_attribute(:address, nil)
    @board.update_attribute(:pending, false)
    @board.update_attribute(:customer_id, nil)
    @board.save
    redirect_to dash_path, flash: {notice: "Charge Successful"}


    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path


    end

    def show
    begin
      # Retrieve the charge from Stripe
      @charge = Stripe::Charge.retrieve(id: params[:id], expand: ['application_fee'])

      # Validate that the user should be able to view this charge
      check_destination(@charge)

      @board = Board.find(@charge.board_id)
    rescue Stripe::RateLimitError => e
      # Too many requests made to the API too quickly
      flash[:error] = e.message
      render :show
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
      flash[:error] = e.message
      render :show
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
      flash[:error] = e.message
      render :show
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
      flash[:error] = e.message
      render :show
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
      flash[:error] = e.message
      render :show
    rescue => e
      # Something else happened, completely unrelated to Stripe
      flash[:error] = e.message
      render :show
    end
  end

    def destroy
    begin
      # Retrieve the charge from Stripe
      charge = Stripe::Charge.retrieve(params[:id])

      # Validate that the user should be able to view this charge
      check_destination(charge)

      # Refund the charge
      charge.refund(reverse_transfer: true, refund_application_fee: true)


      # Update the amount raised for this campaign


      # Let the user know the refund was successful
      flash[:success] = "The charge has been refunded."
      redirect_to dash_path
    rescue Stripe::RateLimitError => e
      # Too many requests made to the API too quickly
      flash[:error] = e.message
      redirect_to dash_path
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
      flash[:error] = e.message
      redirect_to dash_path
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
      flash[:error] = e.message
      redirect_to dash_path
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
      flash[:error] = e.message
      redirect_to dash_path
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
      flash[:error] = e.message
      redirect_to dash_path
    rescue => e
      # Something else happened, completely unrelated to Stripe
      flash[:error] = e.message
      redirect_to dash_path
    end
  end

end
