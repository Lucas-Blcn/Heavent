class ConvertTagsToArrayInEvents < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :tags, :text, array: true, default: [], using: "(string_to_array(tags, ','))"
  end
end
