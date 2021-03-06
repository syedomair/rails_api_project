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

ActiveRecord::Schema.define(version: 20160608092100) do

  create_table "api_keys", force: :cascade do |t|
    t.string "company_name", limit: 255
    t.string "status",       limit: 255
    t.string "api_key",      limit: 255
  end

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
    t.boolean "featured"
  end

  add_index "products", ["categories_id"], name: "IDX_D34A04AD12469DE2", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",              limit: 255
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "encrypted_password", limit: 255
    t.string   "salt",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "categories", "catalogs", column: "catalogs_id", name: "FK_64C19C1CC3C66FC"
  add_foreign_key "products", "categories", column: "categories_id", name: "FK_D34A04AD12469DE2"
end
