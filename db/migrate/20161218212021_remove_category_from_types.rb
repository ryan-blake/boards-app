class RemoveCategoryFromTypes < ActiveRecord::Migration[5.0]
  def change
    remove_column :types, :category_id, :integer
  end
end
