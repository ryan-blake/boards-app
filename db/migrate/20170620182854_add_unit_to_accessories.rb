class AddUnitToAccessories < ActiveRecord::Migration[5.0]
  def change
    add_reference :accessories, :unit, foreign_key: true, index: true
    add_column :accessories, :measure, :decimal
  end
end
