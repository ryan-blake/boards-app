class AddTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :type, index: true, foreign_key: true
  end
end
