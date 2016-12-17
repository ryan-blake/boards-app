class AddAddressToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :address, :string
  end
end
