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

ActiveRecord::Schema.define(version: 2019_08_26_203833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", id: :serial, force: :cascade do |t|
    t.string "photo"
    t.string "attachable_type"
    t.integer "attachable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"
  end

  create_table "buddies", force: :cascade do |t|
    t.string "status"
    t.bigint "one_user_id"
    t.bigint "two_user_id"
    t.bigint "last_action_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_action_user_id"], name: "index_buddies_on_last_action_user_id"
    t.index ["one_user_id"], name: "index_buddies_on_one_user_id"
    t.index ["two_user_id"], name: "index_buddies_on_two_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "number_holes"
    t.integer "difficulty"
    t.string "address"
    t.string "phone"
    t.string "website"
    t.text "about_course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "options"
    t.integer "number_players"
    t.integer "number_guests"
    t.date "date"
    t.time "time"
    t.boolean "booked"
    t.boolean "tournament"
    t.text "about_game"
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.boolean "privacy"
    t.float "game_price"
    t.index ["course_id"], name: "index_games_on_course_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "guests", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["game_id"], name: "index_guests_on_game_id"
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "list_prefs", force: :cascade do |t|
    t.string "name"
  end

  create_table "mailboxer_conversation_opt_outs", id: :serial, force: :cascade do |t|
    t.string "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"
  end

  create_table "mailboxer_conversations", id: :serial, force: :cascade do |t|
    t.string "subject", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailboxer_notifications", id: :serial, force: :cascade do |t|
    t.string "type"
    t.text "body"
    t.string "subject", default: ""
    t.string "sender_type"
    t.integer "sender_id"
    t.integer "conversation_id"
    t.boolean "draft", default: false
    t.string "notification_code"
    t.string "notified_object_type"
    t.integer "notified_object_id"
    t.string "attachment"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.boolean "global", default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
    t.index ["notified_object_type", "notified_object_id"], name: "mailboxer_notifications_notified_object"
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
    t.index ["type"], name: "index_mailboxer_notifications_on_type"
  end

  create_table "mailboxer_receipts", id: :serial, force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "notification_id", null: false
    t.boolean "is_read", default: false
    t.boolean "trashed", default: false
    t.boolean "deleted", default: false
    t.string "mailbox_type", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_delivered", default: false
    t.string "delivery_method"
    t.string "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"
  end

  create_table "user_personalities", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "list_pref_id"
    t.index ["list_pref_id"], name: "index_user_personalities_on_list_pref_id"
    t.index ["user_id"], name: "index_user_personalities_on_user_id"
  end

  create_table "user_preferences", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "list_pref_id"
    t.index ["list_pref_id"], name: "index_user_preferences_on_list_pref_id"
    t.index ["user_id"], name: "index_user_preferences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.date "birth_date"
    t.integer "gender"
    t.string "language"
    t.string "current_city"
    t.float "handicap"
    t.integer "rating"
    t.text "about_me"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "games", "courses"
  add_foreign_key "games", "users"
  add_foreign_key "guests", "games"
  add_foreign_key "guests", "users"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "user_personalities", "list_prefs"
  add_foreign_key "user_personalities", "users"
  add_foreign_key "user_preferences", "list_prefs"
  add_foreign_key "user_preferences", "users"
end
