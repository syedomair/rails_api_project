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

ActiveRecord::Schema.define(version: 20160510064848) do

  create_table "catalogs", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer "catalogs_id", limit: 4
    t.string  "name",        limit: 255, null: false
  end

  add_index "categories", ["catalogs_id"], name: "IDX_64C19C1CC3C66FC", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer "categories_id",     limit: 4
    t.string  "name",              limit: 64,  null: false
    t.string  "sku",               limit: 32
    t.string  "price",             limit: 32
    t.string  "short_description", limit: 255
    t.string  "image",             limit: 32
  end

  add_index "products", ["categories_id"], name: "IDX_D34A04AD12469DE2", using: :btree

  create_table "user", force: :cascade do |t|
    t.string   "email",          limit: 64,  null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "email_verified"
    t.string   "password",       limit: 128, null: false
    t.string   "salt",           limit: 128, null: false
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
  end

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
    t.string   "auth_token",             limit: 255, default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "categories", "catalogs", column: "catalogs_id", name: "FK_64C19C1CC3C66FC"
  add_foreign_key "products", "categories", column: "categories_id", name: "FK_D34A04AD12469DE2"
end
