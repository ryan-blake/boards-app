class AddShippingToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :shipping, :boolean
  end
end
