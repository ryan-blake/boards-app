class AddWidthToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :width, :int
  end
end
