class AddTypeToBoard < ActiveRecord::Migration[5.0]
  def change
    add_reference :boards, :type, foreign_key: true
    add_column :boards, :volume, :int
  end
end
