class TokensController < ApplicationController
  def new
  end

  def create
    @amount = params[:amount]

   @amount = @amount.gsub('$', '').gsub(',', '')

   begin
     @amount = Float(@amount).round(2)
   rescue
     flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
     redirect_to new_charge_path
     return
   end

   @amount = (@amount * 100).to_i # Must be an integer!

   if @amount < 1000
     flash[:error] = 'Charge not completed. Amount must be at least $10.'
     redirect_to root_path
     return
   end

   Stripe::Charge.create(
     source: params[:stripeToken],
     :amount => @amount,
     :currency => 'usd',
     :source => params[:stripeToken],
     :description => 'Custom Tokens'
   )

   @user = current_user
   @user.tokens += (@amount / 100 ) / 2
   @user.save
  redirect_to dash_path
   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charge_path

  end

end
