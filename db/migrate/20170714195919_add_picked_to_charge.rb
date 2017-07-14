class AddPickedToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :picked, :string
    add_column :charges, :shipped, :string
  end
end
