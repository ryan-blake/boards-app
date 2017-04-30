class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :file_id
      t.references :board, foreign_key: true
      t.references :accessory, foreign_key: true

      t.timestamps
    end
  end
end
