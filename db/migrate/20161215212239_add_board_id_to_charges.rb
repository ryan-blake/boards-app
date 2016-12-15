class AddBoardIdToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :board_id, :string
  end
end
