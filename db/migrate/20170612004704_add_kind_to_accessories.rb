class AddKindToAccessories < ActiveRecord::Migration[5.0]
  def change
    add_reference :accessories, :kind, index: true, foreign_key: true
    add_reference :kinds, :category, index: true, foreign_key: true
    add_column :accessories, :price, :money, default: 0
  end
end
