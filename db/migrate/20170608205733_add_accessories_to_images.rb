class AddAccessoriesToImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :images, :accessory, foreign_key: true
  end
end
