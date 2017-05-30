class AddUpcToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :upc, :string
  end
end
