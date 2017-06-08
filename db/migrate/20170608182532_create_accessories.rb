class CreateAccessories < ActiveRecord::Migration[5.0]
  def change
    create_table :accessories do |t|
      t.string :brand
      t.integer :price
      t.integer :inventory
      t.string :color
      t.string :title
      t.timestamps
    end
    add_reference :accessories, :type, foreign_key: true
    add_reference :accessories, :category, foreign_key: true
    add_reference :accessories, :user, index: true, foreign_key: true
    add_reference :accessories, :board, index: true, foreign_key: true

  end
end
