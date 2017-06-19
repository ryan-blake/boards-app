class AddSizeToBoards < ActiveRecord::Migration[5.0]
  def change
    add_reference :boards, :size, foreign_key: true
  end
end
