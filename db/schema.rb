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

ActiveRecord::Schema.define(version: 20170217203547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "ticker"
    t.string   "company_name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.float    "last_price",   default: 0.0
  end

  create_table "user_followers", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "followee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followee_id", "user_id"], name: "index_user_followers_on_followee_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "followee_id"], name: "index_user_followers_on_user_id_and_followee_id", unique: true, using: :btree
  end

  create_table "user_following", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "followee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followee_id", "user_id"], name: "index_user_following_on_followee_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "followee_id"], name: "index_user_following_on_user_id_and_followee_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "avatar"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
