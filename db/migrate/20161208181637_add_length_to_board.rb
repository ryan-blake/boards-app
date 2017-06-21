class AddLengthToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :length, :decimal, :precision => 5, :scale => 2
  end
end
