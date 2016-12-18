class AddShippingToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :shipping, :boolean
  end
end
