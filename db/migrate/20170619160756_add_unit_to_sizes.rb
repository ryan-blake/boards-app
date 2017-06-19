class AddUnitToSizes < ActiveRecord::Migration[5.0]
  def change
    add_reference :sizes, :unit, foreign_key: true
  end
end
