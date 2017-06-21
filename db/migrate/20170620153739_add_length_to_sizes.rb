class AddLengthToSizes < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :length, :decimal,:precision => 5, :scale => 2

    add_column :sizes, :width, :decimal,:precision => 5, :scale => 2

    add_column :sizes, :thickness, :decimal,:precision => 5, :scale => 2

    add_column :sizes, :volume, :decimal, :precision => 5, :scale => 2

  end
end
