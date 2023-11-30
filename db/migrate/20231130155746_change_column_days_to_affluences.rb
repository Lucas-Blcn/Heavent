class ChangeColumnDaysToAffluences < ActiveRecord::Migration[7.1]
  def change
    change_column :affluences, :days, :text, array: true, default: [], using: "days::text[]"
  end
end
