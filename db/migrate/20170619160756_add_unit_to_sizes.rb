class AddUnitToSizes < ActiveRecord::Migration[5.0]
  def change
    add_reference :sizes, :unit, foreign_key: true, default: 1
  end
end
