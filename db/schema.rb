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

ActiveRecord::Schema.define(version: 20150415092023) do

  create_table "computer_wipes", force: true do |t|
    t.integer "wipe_id"
    t.integer "computer_id"
  end

  create_table "computers", force: true do |t|
    t.string   "manufacturer"
    t.string   "computer_type"
    t.string   "model_no"
    t.string   "serial_no"
    t.date     "date"
    t.text     "action_taken"
    t.text     "donor"
    t.text     "specification"
    t.text     "product_key"
    t.string   "initials_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "staff_id"
    t.string   "picture"
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
  end

  create_table "types", force: true do |t|
    t.string "department"
  end

  create_table "wipes", force: true do |t|
    t.date   "date_wiped"
    t.text   "wiped_using"
    t.string "wiped_by"
  end

end
