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

ActiveRecord::Schema.define(version: 20150528135724) do

  create_table "computers", force: true do |t|
    t.string   "manufacturer"
    t.string   "computer_type"
    t.string   "model_no"
    t.string   "serial_no"
    t.text     "specification"
    t.text     "product_key"
    t.string   "turingtrack"
    t.integer  "donor_id"
    t.integer  "hub_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  create_table "decommissions", force: true do |t|
    t.integer  "entertrack"
    t.integer  "staff_id"
    t.integer  "computer_id"
    t.boolean  "decommissioned", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donors", force: true do |t|
    t.string   "donor_name"
    t.string   "donor_email"
    t.text     "donor_address"
    t.boolean  "paper_cert",    default: false
    t.boolean  "allow_mail",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hubs", force: true do |t|
    t.string "hub_location"
  end

  create_table "operating_systems", force: true do |t|
    t.string   "os"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.integer  "entertrack"
    t.integer  "staff_id"
    t.integer  "computer_id"
    t.string   "school"
    t.boolean  "received",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sent_stocks", force: true do |t|
    t.string   "sent_batch_name"
    t.integer  "sent_keyboards"
    t.integer  "sent_mice"
    t.integer  "sent_monitors"
    t.integer  "sent_printers"
    t.integer  "sent_speakers"
    t.integer  "sent_vga_cables"
    t.integer  "sent_kettle_leads"
    t.integer  "sent_routers"
    t.integer  "sent_lan_switches"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipments", force: true do |t|
    t.integer  "entertrack"
    t.integer  "staff_id"
    t.integer  "computer_id"
    t.boolean  "shipped",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff_types", force: true do |t|
    t.integer "type_id"
    t.integer "staff_id"
  end

  create_table "staffs", force: true do |t|
    t.string   "staff_name"
    t.string   "staff_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  create_table "statuses", force: true do |t|
    t.integer  "entertrack"
    t.integer  "staff_id"
    t.integer  "computer_id"
    t.boolean  "scrapped",                            default: false
    t.boolean  "sold",                                default: false
    t.string   "customer"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", force: true do |t|
    t.string   "batch_name"
    t.integer  "keyboards"
    t.integer  "mice"
    t.integer  "monitors"
    t.integer  "printers"
    t.integer  "speakers"
    t.integer  "vga_cables"
    t.integer  "kettle_leads"
    t.integer  "routers"
    t.integer  "lan_switches"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string "department"
  end

  create_table "wipes", force: true do |t|
    t.integer  "staff_id"
    t.integer  "computer_id"
    t.text     "action_taken"
    t.integer  "operating_system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
