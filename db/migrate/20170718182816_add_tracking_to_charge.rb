class AddTrackingToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :tracking, :string
  end
end
