class AddListTimeToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :list_time, :datetime, default: ""
  end
end
