class CreateFins < ActiveRecord::Migration[5.0]
  def change
    create_table :fins do |t|
      t.string :name
      t.timestamps
    end
    add_reference :boards, :fin, foreign_key: true

  end
end
