class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :rating
      t.references :interest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
