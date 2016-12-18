class AddShippedToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :shipped, :boolean, default: nil

  end
end
