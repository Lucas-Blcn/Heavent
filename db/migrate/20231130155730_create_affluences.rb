class CreateAffluences < ActiveRecord::Migration[7.1]
  def change
    create_table :affluences do |t|
      t.string :name
      t.text :days
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
