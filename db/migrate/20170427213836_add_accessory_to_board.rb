class AddAccessoryToBoard < ActiveRecord::Migration[5.0]
  def change

    add_reference :boards, :accessory, foreign_key: true, index: true

  end
end
