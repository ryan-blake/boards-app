class AddDescriptionToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :description, :string
  end
end
