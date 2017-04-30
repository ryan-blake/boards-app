class AddTypeToAccessory < ActiveRecord::Migration[5.0]
  def change
    add_reference :accessories, :type, foreign_key: true,index: true

  end
end
