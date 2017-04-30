class CreateAccessories < ActiveRecord::Migration[5.0]
  def change
    create_table :accessories do |t|
      t.string :name
      t.string :brand
      t.string :color
      t.integer :price
      t.string :inventory

      t.timestamps
    end
  end
end
