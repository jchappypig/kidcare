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

ActiveRecord::Schema.define(version: 20141020035935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string  "category"
    t.string  "day"
    t.text    "cross_mentor"
    t.string  "cross_mentor_outcome"
    t.text    "social"
    t.string  "social_outcome"
    t.text    "art_and_craft"
    t.string  "art_and_craft_outcome"
    t.text    "language"
    t.string  "language_outcome"
    t.integer "weekly_program_id"
    t.text    "cognitive"
    t.string  "cognitive_outcome"
  end

  create_table "outcomes", force: true do |t|
    t.string "item_no"
    t.string "description"
    t.string "category"
  end

  create_table "stories", force: true do |t|
    t.text     "content"
    t.date     "time_line"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "guid"
  end

  create_table "story_attachments", force: true do |t|
    t.integer "story_id"
    t.string  "photo"
    t.uuid    "guid"
  end

  create_table "story_outcomes", force: true do |t|
    t.integer "story_id"
    t.integer "outcome_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "waiting_lists", force: true do |t|
    t.string   "child_full_name"
    t.string   "parent_full_name"
    t.string   "home_phone"
    t.text     "address"
    t.date     "intend_start_date"
    t.string   "days_required"
    t.datetime "date_contacted"
    t.datetime "updated_at"
    t.string   "mobile_phone"
    t.date     "child_dob"
    t.string   "preferred_way_of_contact"
    t.datetime "created_at"
  end

  create_table "weekly_programs", force: true do |t|
    t.date    "week_start"
    t.string  "program_staff"
    t.string  "theme"
    t.string  "goals"
    t.string  "letter"
    t.integer "number"
    t.string  "colour"
    t.string  "shape"
  end

  create_table "white_lists", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
