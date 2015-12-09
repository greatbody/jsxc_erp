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

ActiveRecord::Schema.define(version: 20151209050044) do

  create_table "contact_logs", force: :cascade do |t|
    t.text     "contact_log",     limit: 65535
    t.integer  "contact_type",    limit: 4
    t.integer  "current_status",  limit: 4
    t.integer  "need_contact",    limit: 4
    t.date     "next_contact_at"
    t.integer  "student_id",      limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id",         limit: 4
  end

  add_index "contact_logs", ["student_id"], name: "index_contact_logs_on_student_id", using: :btree
  add_index "contact_logs", ["user_id"], name: "index_contact_logs_on_user_id", using: :btree

  create_table "intentions", force: :cascade do |t|
    t.string   "source",          limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "student_id",      limit: 4
    t.integer  "current_status",  limit: 4,   default: 0
    t.date     "next_contact_at"
    t.integer  "user_id",         limit: 4
  end

  add_index "intentions", ["student_id"], name: "index_intentions_on_student_id", using: :btree
  add_index "intentions", ["user_id"], name: "index_intentions_on_user_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "phone",      limit: 255
    t.string   "name",       limit: 255
    t.integer  "sex",        limit: 4,   default: 1
    t.string   "id_card",    limit: 255
    t.string   "address",    limit: 255
    t.string   "unit",       limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "students", ["user_id"], name: "index_students_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "phone",               limit: 255, default: "", null: false
    t.string   "email",               limit: 255, default: "", null: false
    t.string   "encrypted_password",  limit: 255, default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",  limit: 255
    t.string   "last_sign_in_ip",     limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "name",                limit: 255
  end

  add_index "users", ["phone"], name: "index_users_on_phone", unique: true, using: :btree

  add_foreign_key "contact_logs", "students"
  add_foreign_key "contact_logs", "users"
  add_foreign_key "intentions", "students"
  add_foreign_key "intentions", "users"
  add_foreign_key "students", "users"
end
