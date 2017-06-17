class AddAccArrayToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :accessories, :string
  end
end
