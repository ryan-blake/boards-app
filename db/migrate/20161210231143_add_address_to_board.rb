class AddAddressToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :address, :string
    add_column :boards, :city, :string
    add_column :boards, :state, :string
    add_column :boards, :zipcode, :integer
    add_column :boards, :latitude, :float
    add_column :boards, :longitude, :float
  end
end
