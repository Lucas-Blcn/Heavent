class AddColumnToInterests < ActiveRecord::Migration[7.1]
  def change
    add_column :interests, :liked, :boolean
    add_column :interests, :done, :boolean
  end
end
