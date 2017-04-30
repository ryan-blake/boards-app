class AddVarietyToAccessory < ActiveRecord::Migration[5.0]
  def change
    add_reference :accessories, :variety, foreign_key: true, index: true

  end
end
