class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.integer :price
      t.string :item
      t.integer :user_id
      t.string :token
      t.string :customer_id

      t.timestamps
    end
  end
end
