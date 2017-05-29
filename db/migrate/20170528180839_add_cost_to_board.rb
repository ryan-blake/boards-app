class AddCostToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :cost, :integer
    add_column :boards, :margin, :integer
  end
end
