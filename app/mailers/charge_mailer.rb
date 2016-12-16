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

    mail to: @vendor.email, subject: "new purchase for board"

  end
end
