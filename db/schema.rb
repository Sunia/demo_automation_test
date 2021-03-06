# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150409182515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "email_senders", force: :cascade do |t|
    t.string   "email",      default: "", null: false
    t.string   "first_name", default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "last_name",  default: ""
  end

  create_table "emails", force: :cascade do |t|
    t.string   "email",         default: "",    null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "question"
    t.integer  "listener_id"
    t.integer  "questioner_id"
    t.string   "sender_ids",    default: [],                 array: true
    t.text     "listener_link"
    t.boolean  "is_email_sent", default: false
  end

  create_table "sender_details", force: :cascade do |t|
    t.string   "unique_key", default: "",    null: false
    t.text     "reply",      default: "",    null: false
    t.integer  "email_id",                   null: false
    t.integer  "user_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "reply_time"
    t.boolean  "is_replied", default: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
