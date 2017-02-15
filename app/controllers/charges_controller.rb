class ChargesController < ApplicationController

  def new
    # Stripe::Charge.all(
    #  { customer: stripe_id },
    #  stripe_account: connected_account_id).data
  end



  def create

    customer = Stripe::Customer.create(
      :email => current_user.email,
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
    @board.update_attribute(:arrived, false)
    @board.customer_id = current_user.id
    @board.update_attribute(:pending, true)
    @board.for_sale = false
    @board.save
    # ChargeMailer.new_charge_user(@charge).deliver_now
    # ChargeMailer.new_charge_vendor(@charge).deliver_now

    redirect_to  my_boards_path

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
    @board.update_attribute(:pending, false)
    @board.update_attribute(:customer_id, nil)
    @board.save
    redirect_to my_boards_path, flash: {notice: "Charge Successful"}


    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end

end
