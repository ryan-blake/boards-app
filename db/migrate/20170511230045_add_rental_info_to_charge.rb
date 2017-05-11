class AddRentalInfoToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :rental, :boolean
  end
end
