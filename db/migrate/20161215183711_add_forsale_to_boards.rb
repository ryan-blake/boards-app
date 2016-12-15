class AddForsaleToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :for_sale, :boolean, default: true
  end
end
