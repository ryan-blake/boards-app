class AddLengthToSizes < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :length, :integer
    add_column :sizes, :width, :integer
    add_column :sizes, :thickness, :integer
    add_column :sizes, :volume, :integer
  end
end
