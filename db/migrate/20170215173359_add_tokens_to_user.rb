class AddTokensToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tokens, :integer, :default => 4
  end
end
