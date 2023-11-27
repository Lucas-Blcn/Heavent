class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :status, :string
    add_column :users, :pseudo, :string
  end
end
