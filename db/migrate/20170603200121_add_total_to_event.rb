class AddTotalToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :total, :integer
  end
end
