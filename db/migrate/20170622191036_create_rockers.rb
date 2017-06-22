class CreateRockers < ActiveRecord::Migration[5.0]
    def change
      create_table :rockers do |t|
        t.string :name
        t.timestamps
      end
      add_reference :boards, :rocker, foreign_key: true

    end
  end
