class ChargesController < ApplicationController
  before_action :set_charge, only: [ :update]
  helper_method :sort_column, :sort_direction, :c_ft ,:c_cm, :c_mm

  def new
    # Stripe::Charge.all(
    #  { customer: stripe_id },
    #  stripe_account: connected_account_id).data
  end

    def complete
       @board = Board.find_by(id: @charge.board_id,  arrived: false)

      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = @charge.token
      charge = Stripe::Charge.create({
        :amount => @charge.price*100,
        :description => 'Rails Stripe customer',
        :customer => @charge.customer_id,
        :currency => 'usd',
        :destination => @charge.vendor.stripe_account,
        :application_fee => 200+(@charge.price*3)+ 31,
         metadata: { "shipping" => @charge.shipping, "charge_id" => @charge.id,
            "board" => @board.title, "vendor" => User.find(@charge.vendor).name, "vendor_id" => User.find(@charge.vendor).id,  "customer" => User.find(@charge.user).name, "customer_id" => @charge.user_id }
       },
      )
      @charge.charge_stripe = charge['id']
      @charge.update_attribute(:completed, true)
      @board.update_attribute(:arrived, true)
      @board.user_id = @charge.user_id
      @board.update_attribute(:shipping, nil)
      @board.update_attribute(:shipped, nil)
      @board.update_attribute(:customer_id, nil)
      @board.update_attribute(:address, nil)
      @board.update_attribute(:pending, false)
      @board.update_attribute(:customer_id, nil)
      @board.update_attribute(:company, nil)

      @board.save
      if @new_user
        redirect_to new_user_session_path, :notice => "HOWDY, Your board is ordered! Check your email to create your password and confirm your email."
      else
        redirect_to dash_path, flash: {notice: "Charge Successful"}
      end

      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to charges_path
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
    shipping: params[:charge]["shipping"],
    accessories: params[:charge]["accessories"]
  )

  array = @charge.accessories.split(",")
  if array.count >= 1
    @accessories = Accessory.where(id: array)
    @accessories.each do |i|
      i.inventory += -1
      i.save
    end
  end
  @charge.update_attribute(:boolean, true)
  @charge.save
  @board = Board.where(id: @charge.board_id).first
  @board.shipping = params[:charge]["shipping"]
  @board.update_attribute(:arrived, false)
  @board.customer_id = current_user.id
  @board.update_attribute(:pending, true)
  @board.for_sale = false
  @board.save
  @new_user = false
  complete


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
    current_user.skip_confirmation!
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
      shipping: params[:charge]["shipping"],
      accessories: params[:charge]["accessories"].to_s
    )
    array = @charge.accessories.split(",")
    if array.count >= 1
      @accessories = Accessory.where(id: array)
      @accessories.each do |i|
        i.inventory += -1
        i.save
      end
    end
    @charge.update_attribute(:boolean, true)
    @charge.save
    @board = Board.where(id: @charge.board_id).first
    @board.update_attribute(:arrived, false)
    @board.shipping = params[:charge]["shipping"]
    @board.customer_id = current_user.id
    @board.update_attribute(:pending, true)
    @board.for_sale = false
    @board.save

    @new_user = true
    current_user.send_reset_password_instructions
    complete

   end
 end
end

    def show

    begin
      @charge = Charge.find(params[:id])
      @board = Board.where(:id => @charge.board_id)[0]
      @payments = Stripe::Charge.retrieve(id: @charge.charge_stripe)
      {
        expand: ['data.source_transfer', 'data.application_fee']
      }
      # # Retrieve the charge from Stripe
      # @charge = Stripe::Charge.retrieve(id: params[:id], expand: ['application_fee'])
      #
      # # Validate that the user should be able to view this charge
      # check_destination(@charge)

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
      charge.refund(reverse_transfer: true, refund_application_fee: false)


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
  def update
      respond_to do |format|
        if @charge.update(charge_params)
          format.html { redirect_to @charge, notice: 'Event was successfully updated.' }
          format.json { render :show, status: :ok, location: @charge }
        else
          format.html { render :edit }
          format.json { render json: @charge.errors, status: :unprocessable_entity }
        end
      end
    end

    def picked_boards
      @user = current_user
      @picked_boards = Charge.where(vendor_id: @user.id, shipping: false, picked: false || nil).order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
    end

    def search_picked
      @user = current_user
      @picked_boards = Charge.where(vendor_id: @user.id, shipping: false, picked: false || nil )

        if params[:category_id].present?
            @picked_boards = @picked_boards.joins(:board).where("(upc like ? or title like ? or description like ? or make like ?)","%#{params[:keyword]}%","%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(boards: {category_id: params[:category_id] }).order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
        else
            @picked_boards = @picked_boards.joins(:board).where("(upc like ? or title like ? or description like ? or make like ?)","%#{params[:keyword]}%","%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
        end
        if params[:user].present?
            @picked_boards = @picked_boards.joins(:user).where("(name like ? or email like ?)","%#{params[:user]}%", "%#{params[:user]}%").order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
        end
    end

    def shipped_boards
      @user = current_user
      @shipped_boards = Charge.where(vendor_id: @user.id, shipping: true, shipped: false || nil ).order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
    end

    def search_shipped
      @user = current_user
      @shipped_boards = Charge.where(vendor_id: @user.id, shipping: true, shipped: false || nil )
        if params[:category_id].present?
            @shipped_boards = @shipped_boards.joins(:board).where("(upc like ? or title like ? or description like ? or make like ?)","%#{params[:keyword]}%","%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(boards: {category_id: params[:category_id] }).order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
        else
            @shipped_boards = @shipped_boards.joins(:board).where("(upc like ? or title like ? or description like ? or make like ?)","%#{params[:keyword]}%","%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
        end
        if params[:user].present?
            @shipped_boards = @shipped_boards.joins(:user).where("(name like ? or email like ?)","%#{params[:user]}%", "%#{params[:user]}%").order(sort_column + ' ' + sort_direction).page(params[:page]).per(8)
        end
    end

      def set_charge
        @charge = Charge.find(params[:id])
      end

      def charge_params
        params.permit(:extras, :accessories, :amount ,:picked, :shipped, :id, :price, :item ,:user_id, :vendor_id, :token, :customer_id, :completed, :boolean, :board_id, :address, :shipping, :start_time, :end_time, :rental, :charge_stripe)
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

    def c_ft(a)
      a = (a * 12)
    end

    def c_cm(param)
      param = (param / 2.54)
    end
    def c_mm(param)
      param = (param / 25.4)
    end

end
