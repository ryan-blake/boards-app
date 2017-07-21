class AddShippableToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :shippable, :boolean
    add_column :boards, :rate, :decimal, :precision => 5, :scale => 2
  end
end
