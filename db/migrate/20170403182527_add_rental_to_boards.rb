class AddRentalToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :rental, :boolean, default: false
  end
end
