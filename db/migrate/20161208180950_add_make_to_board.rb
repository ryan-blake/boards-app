class AddMakeToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :make, :string
    add_column :boards, :used, :boolean
    add_column :boards, :price, :integer
    add_column :boards, :footgear, :boolean
  end
end
