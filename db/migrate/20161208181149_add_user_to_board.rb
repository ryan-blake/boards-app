class AddUserToBoard < ActiveRecord::Migration[5.0]
  def change
    add_reference :boards, :user, index: true, foreign_key: true
  end
end
