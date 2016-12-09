class AddPublishableKeyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :publishable_key, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :access_code, :string
    add_column :users, :stripe_user_id, :string
  end
end
