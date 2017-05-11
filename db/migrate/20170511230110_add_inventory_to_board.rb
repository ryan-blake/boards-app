class AddInventoryToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :inventory, :integer, default: 0
  end
end
