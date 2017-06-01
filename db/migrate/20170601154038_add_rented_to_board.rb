class AddRentedToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :rented, :boolean
  end
end
