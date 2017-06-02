class AddVendorToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :vendor_id, :integer
  end
end
