class AddFeetToSizes < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :feet, :integer
    add_column :sizes, :inches, :integer
  end
end
