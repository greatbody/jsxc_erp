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

ActiveRecord::Schema.define(version: 20151229081138) do

  create_table "coaches", force: :cascade do |t|
    t.string   "phone",                             limit: 255
    t.string   "name",                              limit: 255
    t.integer  "gender",                            limit: 4
    t.string   "id_card",                           limit: 255
    t.date     "birthday"
    t.string   "wechat",                            limit: 255
    t.string   "qq",                                limit: 255
    t.string   "coaching_license",                  limit: 255
    t.string   "driving_license",                   limit: 255
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "avatar_file_name",                  limit: 255
    t.string   "avatar_content_type",               limit: 255
    t.integer  "avatar_file_size",                  limit: 4
    t.datetime "avatar_updated_at"
    t.string   "id_card_pic_file_name",             limit: 255
    t.string   "id_card_pic_content_type",          limit: 255
    t.integer  "id_card_pic_file_size",             limit: 4
    t.datetime "id_card_pic_updated_at"
    t.string   "coaching_license_pic_file_name",    limit: 255
    t.string   "coaching_license_pic_content_type", limit: 255
    t.integer  "coaching_license_pic_file_size",    limit: 4
    t.datetime "coaching_license_pic_updated_at"
    t.string   "driving_license_pic_file_name",     limit: 255
    t.string   "driving_license_pic_content_type",  limit: 255
    t.integer  "driving_license_pic_file_size",     limit: 4
    t.datetime "driving_license_pic_updated_at"
    t.integer  "coach_type",                        limit: 4,   default: 0
  end

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

  create_table "residence_cards", force: :cascade do |t|
    t.string   "card_id",               limit: 255
    t.string   "name",                  limit: 255
    t.string   "gender",                limit: 255
    t.string   "ethnicity",             limit: 255
    t.string   "id_card",               limit: 255
    t.string   "home_region",           limit: 255
    t.string   "current_address",       limit: 255
    t.date     "validate_begin_at"
    t.date     "validate_end_at"
    t.integer  "current_status",        limit: 4,   default: 0
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "student_id",            limit: 4
    t.integer  "process_by",            limit: 4,   default: 0
    t.string   "card_pic_file_name",    limit: 255
    t.string   "card_pic_content_type", limit: 255
    t.integer  "card_pic_file_size",    limit: 4
    t.datetime "card_pic_updated_at"
    t.date     "notify_at"
    t.date     "last_notify_at"
    t.date     "fatch_notify_at"
    t.date     "last_fatch_notify_at"
    t.date     "id_card_received_at"
    t.date     "id_card_returned_at"
    t.date     "have_number_at"
    t.date     "notify_sent_at"
    t.date     "have_card_at"
    t.date     "return_card_at"
  end

  add_index "residence_cards", ["student_id"], name: "index_residence_cards_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "phone",                         limit: 255
    t.string   "name",                          limit: 255
    t.integer  "sex",                           limit: 4,   default: 1
    t.string   "id_card",                       limit: 255
    t.string   "address",                       limit: 255
    t.string   "unit",                          limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "user_id",                       limit: 4
    t.integer  "coach_id",                      limit: 4
    t.string   "avatar_file_name",              limit: 255
    t.string   "avatar_content_type",           limit: 255
    t.integer  "avatar_file_size",              limit: 4
    t.datetime "avatar_updated_at"
    t.string   "id_card_pic_file_name",         limit: 255
    t.string   "id_card_pic_content_type",      limit: 255
    t.integer  "id_card_pic_file_size",         limit: 4
    t.datetime "id_card_pic_updated_at"
    t.string   "id_card_back_pic_file_name",    limit: 255
    t.string   "id_card_back_pic_content_type", limit: 255
    t.integer  "id_card_back_pic_file_size",    limit: 4
    t.datetime "id_card_back_pic_updated_at"
    t.integer  "is_local",                      limit: 4,   default: 0
  end

  add_index "students", ["coach_id"], name: "index_students_on_coach_id", using: :btree
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
  add_foreign_key "residence_cards", "students"
  add_foreign_key "students", "coaches"
  add_foreign_key "students", "users"
end
