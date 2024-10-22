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

ActiveRecord::Schema[7.1].define(version: 2024_03_11_100313) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email", null: false
    t.datetime "scheduled_at", null: false
    t.uuid "assigned_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_bookings_on_unit_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "listing_amenities", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "is_available", default: false
    t.text "metadata"
    t.integer "listing_type", default: 0, null: false
    t.bigint "listing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_listing_amenities_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "size"
    t.text "metadata"
    t.integer "floor_count"
    t.string "site_link"
    t.integer "listing_type", default: 0, null: false
    t.uuid "user_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_listings_on_location_id"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "address", null: false
    t.string "city", null: false
    t.string "state"
    t.string "postal_code"
    t.string "country"
    t.string "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unit_wishlists", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.bigint "unit_id", null: false
    t.string "title"
    t.datetime "saved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_unit_wishlists_on_unit_id"
    t.index ["user_id"], name: "index_unit_wishlists_on_user_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.uuid "user_id"
    t.integer "size"
    t.integer "amount", null: false
    t.integer "unit_type", null: false
    t.integer "unit_lease_type", null: false
    t.integer "bedroom_count"
    t.integer "bathroom_count"
    t.integer "full_bathroom_count"
    t.text "description"
    t.string "identifier"
    t.boolean "is_available"
    t.datetime "availability_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_units_on_listing_id"
    t.index ["user_id"], name: "index_units_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_proprietor", null: false
    t.boolean "is_occupant", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "units"
  add_foreign_key "listing_amenities", "listings"
  add_foreign_key "listings", "locations"
  add_foreign_key "listings", "users"
  add_foreign_key "unit_wishlists", "units"
  add_foreign_key "unit_wishlists", "users"
  add_foreign_key "units", "listings"
  add_foreign_key "units", "users"
end
