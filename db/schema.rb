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

ActiveRecord::Schema.define(version: 20130916182652) do

  create_table "daily_stats", force: true do |t|
    t.string   "currency_symbol",        default: "$"
    t.integer  "min_price_low_integer",  default: 0
    t.integer  "min_price_high_integer", default: 0
    t.integer  "quantity_low",           default: 0
    t.integer  "quantity_high",          default: 0
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "link_url"
    t.string   "image_url"
    t.boolean  "foil"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
