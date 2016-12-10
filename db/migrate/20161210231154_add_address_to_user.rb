class AddAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :integer
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
