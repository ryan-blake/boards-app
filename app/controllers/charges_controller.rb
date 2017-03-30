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
    shipping:params[:charge]["shipping"]
  )


  @charge.update_attribute(:boolean, true)
  @charge.save
  @board = Board.where(id: @charge.board_id).first
  if @charge.shipping == true
    @board.address = params[:stripeShippingAddressLine1]
    @board.zipcode = params[:stripeShippingAddressZip]
    @board.city = params[:stripeShippingAddressCity]
    @board.state = params[:stripeShippingAddressState]
  end
  @board.update_attribute(:arrived, false)
  @board.customer_id = current_user.id
  @board.update_attribute(:pending, true)
  @board.for_sale = false
  @board.save
  redirect_to  my_boards_path


  # ChargeMailer.new_charge_user(@charge).deliver_now
  # ChargeMailer.new_charge_vendor(@charge).deliver_now

    else !current_user
      @board = Board.where(:id => params[:charge][:board_id]).first
      user_email = params[:stripeEmail]
      if User.where(:email => user_email).exists?

        redirect_to @board, flash: {notice: "Howdy, #{params[:stripeEmail]} is already in use please login or use a different email to continue with your purchase."}
      else
        # if shipping == true add stripe params for shipping to User as shipping address
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
    )

    @charge.update_attribute(:boolean, true)
    @charge.save
    @board = Board.where(id: @charge.board_id).first
    if @charge.shipping == true
      @board.address = params[:stripeShippingAddressLine1]
      @board.zipcode = params[:stripeShippingAddressZip]
      @board.city = params[:stripeShippingAddressCity]
      @board.state = params[:stripeShippingAddressState]
    end
    @board.update_attribute(:arrived, false)
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
    @board = Board.find_by(user: @charge.vendor_id, arrived: false, title: @charge.item)
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:token]
    charge = Stripe::Charge.create({
      :amount => @charge.price*100,
      :description => 'Rails Stripe customer',
      :customer => params[:customer_id],
      :currency => 'usd',
      :destination => @charge.vendor.uid,
      :application_fee => 200+(@charge.price*3)+ 31
      },
    )
    @charge.update_attribute(:completed, true)
    @board.update_attribute(:arrived, true)
    @board.user_id = @charge.user_id
    @board.update_attribute(:shipping, nil)
    @board.update_attribute(:shipped, nil)
    @board.update_attribute(:customer_id, nil)
    @board.update_attribute(:address, nil)
    @board.update_attribute(:city, nil)
    @board.update_attribute(:state, nil)
    @board.update_attribute(:zipcode, nil)
    @board.update_attribute(:longitude, nil)
    @board.update_attribute(:latitude, nil)
    @board.update_attribute(:pending, false)
    @board.update_attribute(:customer_id, nil)
    @board.save
    redirect_to my_boards_path, flash: {notice: "Charge Successful"}


    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path


    end
end
