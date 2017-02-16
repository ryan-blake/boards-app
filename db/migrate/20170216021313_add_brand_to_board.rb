class AddBrandToBoard < ActiveRecord::Migration[5.0]
  def change
    add_reference :boards, :brand, foreign_key: true
  end
end
