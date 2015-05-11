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

ActiveRecord::Schema.define(version: 20140708185643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_bets"
    t.integer  "tickets_by_bet"
    t.integer  "total_tickets_value"
    t.integer  "count_of_bets"
    t.string   "state"
    t.datetime "closed_time"
    t.integer  "category_id"
    t.string   "product_name"
    t.integer  "product_id"
  end

  add_index "auctions", ["id"], name: "index_auctions_on_id", using: :btree
  add_index "auctions", ["tickets_by_bet"], name: "index_auctions_on_tickets_by_bet", using: :btree
  add_index "auctions", ["total_bets"], name: "index_auctions_on_total_bets", using: :btree
  add_index "auctions", ["total_tickets_value"], name: "index_auctions_on_total_tickets_value", using: :btree

  create_table "bets", force: true do |t|
    t.integer  "auction_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  add_index "bets", ["auction_id"], name: "index_bets_on_auction_id", using: :btree
  add_index "bets", ["user_id"], name: "index_bets_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "count_of_auctions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "category"
  end

  create_table "tickets", force: true do |t|
    t.integer  "valor"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "auction_id"
  end

  create_table "users", force: true do |t|
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
    t.string   "authentication_token"
    t.string   "fullname"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "winners", force: true do |t|
    t.integer  "user_id"
    t.integer  "auction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
