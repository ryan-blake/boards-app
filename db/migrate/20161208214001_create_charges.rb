class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.string :item
      t.integer :price
      t.integer :user_id
      t.integer :vendor_id
      t.string :token
      t.string :customer_id
      t.boolean :completed
      t.integer :stripe_user_id

      t.timestamps
    end
  end
end
