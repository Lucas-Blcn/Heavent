class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :chapeau
      t.text :description
      t.string :start_date
      t.string :end_date
      t.text :description_date
      t.string :url_image
      t.string :type_of_price
      t.text :price_details
      t.string :url_link
      t.string :tags
      t.string :place_name
      t.string :address
      t.string :zip_code
      t.string :gps_coord
      t.string :access
      t.string :url_to_book
      t.string :background_image

      t.timestamps
    end
  end
end
