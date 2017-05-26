class AddChargeCustomerToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :charge_stripe, :string
  end
end
