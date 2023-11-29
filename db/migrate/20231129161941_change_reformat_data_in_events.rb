class ChangeReformatDataInEvents < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :start_date, :date, using: "start_date::date"
    change_column :events, :end_date, :date, using: "end_date::date"
  end
end
