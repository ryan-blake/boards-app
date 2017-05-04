class CreateAdditions < ActiveRecord::Migration[5.0]
  def change
    create_table :additions do |t|
      t.string :title
      t.integer :price
      t.integer :inventory

      t.timestamps
    end
  end
end
