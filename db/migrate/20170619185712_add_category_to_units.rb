class AddCategoryToUnits < ActiveRecord::Migration[5.0]
  def change
    add_reference :units, :category, foreign_key: true
  end
end
