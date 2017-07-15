class AddBoardIdToCharges < ActiveRecord::Migration[5.0]
  def change
    add_reference :charges, :board, index: true, foreign_key: true
  end
end
