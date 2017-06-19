class AddSizeToBoards < ActiveRecord::Migration[5.0]
  def change

    add_reference :sizes, :board, index: true, foreign_key: true

  end
end
