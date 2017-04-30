class AddTypeToVariety < ActiveRecord::Migration[5.0]
  def change
    add_reference :varieties, :type, foreign_key: true, index: true
  end
end
