class AddLengthToSizes < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :length, :decimal,:scale => 2

    add_column :sizes, :width, :decimal,:scale => 2

    add_column :sizes, :thickness, :decimal,:scale => 2

    add_column :sizes, :volume, :decimal, :scale => 2

  end
end
