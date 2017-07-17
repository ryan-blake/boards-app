class AddZipToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :zipcode, :string
    add_column :charges, :country, :string
    add_column :charges, :state, :string
    add_column :charges, :city, :string
  end
end
