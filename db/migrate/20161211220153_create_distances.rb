class CreateDistances < ActiveRecord::Migration[5.0]
  def change
    create_table :distances do |t|
      t.integer :value
      t.references :board, index: true, foreign_key: true

      t.timestamps
    end
  end
end
