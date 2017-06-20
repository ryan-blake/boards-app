class AddLengthsToSizes < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :length, :integer
  end
end
