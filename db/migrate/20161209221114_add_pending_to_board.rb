class AddPendingToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :pending, :boolean
  end
end
