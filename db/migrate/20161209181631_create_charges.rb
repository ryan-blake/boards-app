class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.integer :price
      t.string :item
      t.references :user, index: true, foreign_key: true
      t.integer :vendor_id
      t.string :token
      t.string :customer_id
      t.boolean :completed, :boolean, default: false

      t.timestamps null: false
    end
  end
end
