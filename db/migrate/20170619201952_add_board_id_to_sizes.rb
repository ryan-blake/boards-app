class AddBoardIdToSizes < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :board_id, :integer
  end
end
