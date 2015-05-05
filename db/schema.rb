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

ActiveRecord::Schema.define(version: 20150503222136) do

  create_table "computers", force: true do |t|
    t.string   "manufacturer"
    t.string   "computer_type"
    t.string   "model_no"
    t.string   "serial_no"
    t.text     "specification"
    t.text     "product_key"
    t.string   "turingtrack"
    t.integer  "donor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  create_table "donors", force: true do |t|
    t.string   "donor_name"
    t.string   "donor_email"
    t.boolean  "allow_mail",  default: false
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

  create_table "stocks", force: true do |t|
    t.integer  "keyboards"
    t.integer  "mice"
    t.integer  "monitors"
    t.integer  "printers"
    t.integer  "speakers"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
