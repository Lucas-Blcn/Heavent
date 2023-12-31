# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_30_155746) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affluences", force: :cascade do |t|
    t.string "name"
    t.text "days", default: [], array: true
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_affluences_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "chapeau"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.text "description_date"
    t.string "url_image"
    t.string "type_of_price"
    t.text "price_details"
    t.string "url_link"
    t.text "tags", default: [], array: true
    t.string "place_name"
    t.string "address"
    t.string "zip_code"
    t.string "gps_coord"
    t.string "access"
    t.string "url_to_book"
    t.string "background_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "interests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "liked"
    t.boolean "done"
    t.index ["event_id"], name: "index_interests_on_event_id"
    t.index ["user_id"], name: "index_interests_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "content"
    t.integer "rating"
    t.bigint "interest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interest_id"], name: "index_reviews_on_interest_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "pseudo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "affluences", "events"
  add_foreign_key "interests", "events"
  add_foreign_key "interests", "users"
  add_foreign_key "reviews", "interests"
end
