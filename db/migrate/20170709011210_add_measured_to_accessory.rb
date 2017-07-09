class AddMeasuredToAccessory < ActiveRecord::Migration[5.0]
  def change
    add_column :accessories, :measured, :decimal, :precision => 5, :scale => 2
  end
end
