class AddCompanyToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :company, :string
  end
end
