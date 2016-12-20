class AddTrackingToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :tracking, :string
  end
end
