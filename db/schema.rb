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

ActiveRecord::Schema.define(version: 20170120044923) do

  create_table "rtmm_apple_records", force: :cascade do |t|
    t.string   "who",        limit: 255
    t.string   "date",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "rtmm_categories", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "keyword_one",      limit: 255
    t.string   "keyword_two",      limit: 255
    t.string   "keyword_three",    limit: 255
    t.string   "keyword_four",     limit: 255
    t.string   "keyword_five",     limit: 255
    t.string   "total_percent",    limit: 255
    t.string   "other_prefecture", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rtmm_histories", force: :cascade do |t|
    t.string   "who",            limit: 255
    t.string   "key",            limit: 255
    t.string   "val",            limit: 255
    t.integer  "residence_time", limit: 4
    t.string   "category",       limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "rtmm_messages", force: :cascade do |t|
    t.integer  "rtmm_category_id", limit: 4
    t.text     "messages",         limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "rtmm_records", force: :cascade do |t|
    t.string   "who",        limit: 255
    t.datetime "date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "rtmm_users", force: :cascade do |t|
    t.string   "who",        limit: 255
    t.integer  "category",   limit: 4
    t.boolean  "is_online",  limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "rtmms", force: :cascade do |t|
    t.string   "who",           limit: 255
    t.string   "key",           limit: 255
    t.string   "val",           limit: 255
    t.integer  "rtmm_category", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "rtmms", ["who"], name: "index_rtmms_on_who", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
