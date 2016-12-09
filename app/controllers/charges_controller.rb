class ChargesController < ApplicationController
  def new
end

def complete
  @charge = Charge.find(params[:charge_id])
  @board = board.find_by(user: @charge.vendor_id, arrived: false, title: @charge.item)
  @event = @board.events.find_by(booked: true, user_id: current_user.id)

  Stripe.api_key = ENV["stripe_api_key"]
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
  @event.update_attribute(:payed, true)
  redirect_to  my_boards_path



  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
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
  completed: false
  )
  @charge.update_attribute(:boolean, true)
  @charge.save

  @board = board.where(title: @charge.item).first
  @board.arrived = false
  @board.save
  @event = @board.events.find_by(user_id: current_user.id, booked: false)
  @event.booked = true
  @event.charge_id = @charge.id
  @event.save
  redirect_to  my_boards_path

end
end
