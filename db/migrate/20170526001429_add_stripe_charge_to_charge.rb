class AddStripeChargeToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :stripe_charge, :integer
  end
end
