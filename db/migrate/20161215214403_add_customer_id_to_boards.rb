class AddCustomerIdToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :customer_id, :string
  end
end
