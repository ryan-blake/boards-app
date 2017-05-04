# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170501193618) do

  create_table "accessories", force: :cascade do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "color"
    t.integer  "price"
    t.string   "inventory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "board_id"
    t.integer  "type_id"
    t.integer  "variety_id"
    t.index ["board_id"], name: "index_accessories_on_board_id"
    t.index ["type_id"], name: "index_accessories_on_type_id"
    t.index ["variety_id"], name: "index_accessories_on_variety_id"
  end

  create_table "additions", force: :cascade do |t|
    t.string   "title"
    t.integer  "price"
    t.integer  "inventory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "board_id"
    t.index ["board_id"], name: "index_additions_on_board_id"
    t.index ["user_id"], name: "index_additions_on_user_id"
  end

  create_table "boards", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "make"
    t.boolean  "used"
    t.integer  "price"
    t.boolean  "footgear"
    t.integer  "user_id"
    t.string   "description"
    t.integer  "length"
    t.string   "title"
    t.integer  "width"
    t.integer  "type_id"
    t.integer  "volume"
    t.boolean  "arrived",      default: false
    t.boolean  "pending",      default: false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "distance_id"
    t.integer  "category_id"
    t.boolean  "for_sale",     default: true
    t.string   "customer_id"
    t.boolean  "shipping"
    t.boolean  "shipped"
    t.string   "tracking"
    t.boolean  "rental",       default: false
    t.integer  "accessory_id"
    t.index ["accessory_id"], name: "index_boards_on_accessory_id"
    t.index ["category_id"], name: "index_boards_on_category_id"
    t.index ["type_id"], name: "index_boards_on_type_id"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "type_id"
    t.index ["type_id"], name: "index_categories_on_type_id"
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "price"
    t.string   "item"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.string   "token"
    t.string   "customer_id"
    t.boolean  "completed",   default: false
    t.boolean  "boolean",     default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "board_id"
    t.string   "address"
    t.boolean  "shipping"
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["recipient_id", "sender_id"], name: "index_conversations_on_recipient_id_and_sender_id", unique: true
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "distances", force: :cascade do |t|
    t.integer  "value"
    t.integer  "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_distances_on_board_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "tag"
    t.string   "repeat"
    t.boolean  "payed",      default: false
    t.boolean  "booked",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.integer  "board_id"
    t.integer  "charge_id"
    t.string   "name"
    t.index ["board_id"], name: "index_events_on_board_id"
    t.index ["charge_id"], name: "index_events_on_charge_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "file_id"
    t.integer  "board_id"
    t.integer  "accessory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["accessory_id"], name: "index_images_on_accessory_id"
    t.index ["board_id"], name: "index_images_on_board_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.integer  "rating"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "stripe_accounts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "business_name"
    t.string   "account_type"
    t.integer  "dob_month"
    t.integer  "dob_day"
    t.integer  "dob_year"
    t.string   "address_city"
    t.string   "string"
    t.string   "address_state"
    t.string   "address_line1"
    t.string   "address_postal"
    t.boolean  "tos"
    t.boolean  "boolean"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.integer  "price"
    t.string   "item"
    t.integer  "user_id"
    t.string   "token"
    t.string   "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_providers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_providers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.string   "publishable_key"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_code"
    t.string   "stripe_user_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "tokens",                 default: 4
    t.string   "company"
    t.string   "stripe_account"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "varieties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "type_id"
    t.index ["type_id"], name: "index_varieties_on_type_id"
  end

end
