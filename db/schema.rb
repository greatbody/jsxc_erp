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

ActiveRecord::Schema.define(version: 20160225093813) do

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
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
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
    t.date     "signed_at"
    t.integer  "train_school_id",                   limit: 4
    t.date     "contract_begin_at"
    t.date     "contract_end_at"
    t.boolean  "is_locked",                                     default: false
    t.string   "zfb",                               limit: 255
    t.string   "bank",                              limit: 255
    t.string   "bank_card",                         limit: 255
  end

  add_index "coaches", ["train_school_id"], name: "index_coaches_on_train_school_id", using: :btree

  create_table "coaches_train_fields", id: false, force: :cascade do |t|
    t.integer "train_field_id", limit: 4, null: false
    t.integer "coach_id",       limit: 4, null: false
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

  create_table "daily_signs", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "daily_signs", ["user_id"], name: "index_daily_signs_on_user_id", using: :btree

  create_table "intentions", force: :cascade do |t|
    t.string   "source",            limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "student_id",        limit: 4
    t.integer  "current_status",    limit: 4,   default: 0
    t.date     "next_contact_at"
    t.integer  "user_id",           limit: 4
    t.integer  "student_source_id", limit: 4
  end

  add_index "intentions", ["student_id"], name: "index_intentions_on_student_id", using: :btree
  add_index "intentions", ["student_source_id"], name: "index_intentions_on_student_source_id", using: :btree
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
    t.date     "applyed_at"
  end

  add_index "residence_cards", ["student_id"], name: "index_residence_cards_on_student_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "province",   limit: 255
    t.string   "city",       limit: 255
    t.text     "describe",   limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "district",   limit: 255
    t.decimal  "longitude",                precision: 10, scale: 6
    t.decimal  "latitude",                 precision: 10, scale: 6
  end

  create_table "schools_train_fields", id: false, force: :cascade do |t|
    t.integer "train_field_id", limit: 4, null: false
    t.integer "school_id",      limit: 4, null: false
  end

  add_index "schools_train_fields", ["school_id", "train_field_id"], name: "index_schools_train_fields_on_school_id_and_train_field_id", using: :btree
  add_index "schools_train_fields", ["train_field_id", "school_id"], name: "index_schools_train_fields_on_train_field_id_and_school_id", using: :btree

  create_table "source_contacts", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "business",          limit: 255
    t.text     "content",           limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "student_source_id", limit: 4
  end

  add_index "source_contacts", ["student_source_id"], name: "index_source_contacts_on_student_source_id", using: :btree

  create_table "source_contracts", force: :cascade do |t|
    t.date     "sign_at"
    t.date     "begin_at"
    t.date     "end_at"
    t.text     "contract_log",      limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "student_source_id", limit: 4
  end

  add_index "source_contracts", ["student_source_id"], name: "index_source_contracts_on_student_source_id", using: :btree

  create_table "student_sources", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "phone",        limit: 255
    t.string   "class_name",   limit: 255
    t.string   "id_card",      limit: 255
    t.string   "qr_code",      limit: 255
    t.string   "email",        limit: 255
    t.string   "qq",           limit: 255
    t.string   "alipay",       limit: 255
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "school_id",    limit: 4
    t.integer  "gender",       limit: 4,                             default: 1
    t.integer  "user_id",      limit: 4
    t.text     "remarks",      limit: 65535
    t.date     "signed_at"
    t.decimal  "deposit",                    precision: 8, scale: 2
    t.decimal  "deposit_paid",               precision: 8, scale: 2
  end

  add_index "student_sources", ["school_id"], name: "index_student_sources_on_school_id", using: :btree
  add_index "student_sources", ["user_id"], name: "index_student_sources_on_user_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "phone",                         limit: 255
    t.string   "name",                          limit: 255
    t.integer  "sex",                           limit: 4,                             default: 1
    t.string   "id_card",                       limit: 255
    t.string   "address",                       limit: 255
    t.string   "unit",                          limit: 255
    t.datetime "created_at",                                                                      null: false
    t.datetime "updated_at",                                                                      null: false
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
    t.integer  "is_local",                      limit: 4,                             default: 0
    t.string   "swift_number",                  limit: 255
    t.date     "signed_at"
    t.date     "birthday"
    t.integer  "train_service_id",              limit: 4
    t.integer  "process",                       limit: 4,                             default: 0
    t.decimal  "price",                                       precision: 8, scale: 2
    t.text     "evaluation",                    limit: 65535
    t.integer  "possibility",                   limit: 4
    t.string   "last_evaluation_by",            limit: 255
  end

  add_index "students", ["coach_id"], name: "index_students_on_coach_id", using: :btree
  add_index "students", ["train_service_id"], name: "index_students_on_train_service_id", using: :btree
  add_index "students", ["user_id"], name: "index_students_on_user_id", using: :btree

  create_table "train_fields", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "longitude",              precision: 10, scale: 6
    t.decimal  "latitude",               precision: 10, scale: 6
    t.boolean  "locked"
    t.integer  "rate",       limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "train_schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "web_site",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "train_services", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "coach_id",        limit: 4
    t.integer  "train_field_id",  limit: 4
    t.decimal  "base_price",                  precision: 10
    t.decimal  "price",                       precision: 10
    t.decimal  "discount_price",              precision: 10
    t.boolean  "sr_health_check"
    t.boolean  "sr_km1"
    t.boolean  "sr_km2"
    t.boolean  "sr_km3"
    t.boolean  "sr_km4"
    t.decimal  "sim_km2_price",               precision: 10
    t.decimal  "sim_km3_price",               precision: 10
    t.decimal  "km2_bk_fee",                  precision: 10
    t.decimal  "km3_bk_fee",                  precision: 10
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.decimal  "km1_bk_fee",                  precision: 10
  end

  add_index "train_services", ["coach_id"], name: "index_train_services_on_coach_id", using: :btree
  add_index "train_services", ["train_field_id"], name: "index_train_services_on_train_field_id", using: :btree

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
    t.boolean  "admin"
    t.string   "weixin",              limit: 255, default: ""
  end

  add_index "users", ["phone"], name: "index_users_on_phone", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "coaches", "train_schools"
  add_foreign_key "contact_logs", "students"
  add_foreign_key "contact_logs", "users"
  add_foreign_key "daily_signs", "users"
  add_foreign_key "intentions", "student_sources"
  add_foreign_key "intentions", "students"
  add_foreign_key "intentions", "users"
  add_foreign_key "residence_cards", "students"
  add_foreign_key "source_contacts", "student_sources"
  add_foreign_key "source_contracts", "student_sources"
  add_foreign_key "student_sources", "schools"
  add_foreign_key "student_sources", "users"
  add_foreign_key "students", "coaches"
  add_foreign_key "students", "train_services"
  add_foreign_key "students", "users"
  add_foreign_key "train_services", "coaches"
  add_foreign_key "train_services", "train_fields"
end
