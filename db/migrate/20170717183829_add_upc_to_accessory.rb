class AddUpcToAccessory < ActiveRecord::Migration[5.0]
  def change
    add_column :accessories, :upc, :string
  end
end
