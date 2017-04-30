class AddCategoryToBoard < ActiveRecord::Migration[5.0]
  def change
    add_reference :boards, :category, foreign_key: true

  end
end
