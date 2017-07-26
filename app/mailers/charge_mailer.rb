class ChargeMailer < ApplicationMailer
  def new_charge_user(charge)
      @charge = charge
      @vendor = charge.vendor
      @user = charge.user
      @deliver = []
      @deliver.push(@user)
      mail to: @user.email, subject: "new purchase for board #{@charge.item}"
  end

  def new_charge_vendor(charge)
    @charge = charge
    @vendor = charge.vendor
    @deliver = []
    @deliver.push(@user)
    process = @charge.shipping == true ? ": shipping " : ": pick up"
    mail to: @vendor.email, subject: "new purchase for board #{process}"
  end

     def tracking_number(charge)
       @charge = charge
       a = @charge.user_id
       @customer = User.where(id: a).first
       mail to: @customer.email, subject: "Tracking number .. #{charge.item}"
     end
end
