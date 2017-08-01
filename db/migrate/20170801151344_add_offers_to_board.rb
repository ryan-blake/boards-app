class AddOffersToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :offers, :boolean
  end
end
