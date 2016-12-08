class AddLengthToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :length, :integer
  end
end
