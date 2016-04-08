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

ActiveRecord::Schema.define(version: 20160408215415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_points", force: :cascade do |t|
    t.text     "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hub_printers", force: :cascade do |t|
    t.integer  "printer_id"
    t.integer  "hub_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hub_printers", ["hub_id"], name: "index_hub_printers_on_hub_id", using: :btree
  add_index "hub_printers", ["printer_id"], name: "index_hub_printers_on_printer_id", using: :btree

  create_table "hub_sensors", force: :cascade do |t|
    t.integer  "sensor_id"
    t.integer  "hub_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hub_sensors", ["hub_id"], name: "index_hub_sensors_on_hub_id", using: :btree
  add_index "hub_sensors", ["sensor_id"], name: "index_hub_sensors_on_sensor_id", using: :btree

  create_table "hubs", force: :cascade do |t|
    t.text     "friendly_id"
    t.text     "location"
    t.text     "ip"
    t.text     "hostname"
    t.text     "status"
    t.text     "desc"
    t.string   "provider",           default: "api_token", null: false
    t.string   "uid",                default: "",          null: false
    t.string   "encrypted_password", default: "",          null: false
    t.integer  "sign_in_count",      default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "api_token"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hubs", ["friendly_id"], name: "index_hubs_on_friendly_id", unique: true, using: :btree
  add_index "hubs", ["uid", "provider"], name: "index_hubs_on_uid_and_provider", unique: true, using: :btree

  create_table "jobs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "job_id"
    t.jsonb    "data"
  end

  add_index "jobs", ["job_id"], name: "index_jobs_on_job_id", unique: true, using: :btree

  create_table "printer_jobs", force: :cascade do |t|
    t.integer  "printer_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "printer_jobs", ["job_id"], name: "index_printer_jobs_on_job_id", using: :btree
  add_index "printer_jobs", ["printer_id"], name: "index_printer_jobs_on_printer_id", using: :btree

  create_table "printers", force: :cascade do |t|
    t.text     "manufacturer"
    t.text     "model"
    t.text     "status"
    t.text     "friendly_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "num_jobs"
    t.string   "desc"
  end

  add_index "printers", ["friendly_id"], name: "index_printers_on_friendly_id", unique: true, using: :btree

  create_table "sensor_data_points", force: :cascade do |t|
    t.integer  "sensor_id"
    t.integer  "data_point_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "sensor_data_points", ["data_point_id"], name: "index_sensor_data_points_on_data_point_id", using: :btree
  add_index "sensor_data_points", ["sensor_id"], name: "index_sensor_data_points_on_sensor_id", using: :btree

  create_table "sensors", force: :cascade do |t|
    t.text     "category"
    t.text     "model"
    t.text     "manufacturer"
    t.text     "friendly_id"
    t.text     "desc"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "sensors", ["friendly_id"], name: "index_sensors_on_friendly_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email",                                        null: false
    t.string   "uid",                    default: "",                                             null: false
    t.string   "encrypted_password",     default: "",                                             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                                              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image",                  default: "https://www.gravatar.com/avatar/?d=identicon"
    t.string   "email"
    t.boolean  "admin",                  default: false
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
