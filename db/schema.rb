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

ActiveRecord::Schema.define(version: 20161016231404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: :cascade do |t|
    t.string   "lot"
    t.integer  "flavor_id"
    t.integer  "gallons"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.date     "best_by"
    t.integer  "status",     default: 0
  end

  add_index "batches", ["flavor_id"], name: "index_batches_on_flavor_id", using: :btree

  create_table "components", force: :cascade do |t|
    t.integer  "flavor_id"
    t.integer  "ingredient_id"
    t.decimal  "percentage",    precision: 8, scale: 5
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "components", ["flavor_id"], name: "index_components_on_flavor_id", using: :btree
  add_index "components", ["ingredient_id"], name: "index_components_on_ingredient_id", using: :btree

  create_table "flavors", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "archive",      default: false
    t.integer  "gpg"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "archived",   default: false
  end

  create_table "kegs", force: :cascade do |t|
    t.text     "serial_number"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "location",      default: "Teeccino Warehouse"
    t.boolean  "archive",       default: false
    t.integer  "status",        default: 0
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname"
    t.string   "lname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "batches", "flavors"
  add_foreign_key "components", "flavors"
  add_foreign_key "components", "ingredients"
end
