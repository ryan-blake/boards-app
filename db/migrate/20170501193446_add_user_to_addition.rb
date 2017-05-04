class AddUserToAddition < ActiveRecord::Migration[5.0]
  def change
    add_reference :additions, :user, foreign_key: true
  end
end
