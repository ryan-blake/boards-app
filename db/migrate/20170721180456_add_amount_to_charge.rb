class AddAmountToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :price, :money, default: 0
end
