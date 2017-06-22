class CreateTails < ActiveRecord::Migration[5.0]
  def change
    create_table :tails do |t|
      t.string :name

      t.timestamps
    end
    add_reference :boards, :tail, index: true, foreign_key: true
  end
end
