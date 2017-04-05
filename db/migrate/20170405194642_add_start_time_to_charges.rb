class AddStartTimeToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :start_time, :datetime
    add_column :charges, :end_time, :datetime
  end
end
