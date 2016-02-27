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

ActiveRecord::Schema.define(version: 20160227203137) do

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
    t.index ["hub_id"], name: "index_hub_printers_on_hub_id", using: :btree
    t.index ["printer_id"], name: "index_hub_printers_on_printer_id", using: :btree
  end

  create_table "hub_sensors", force: :cascade do |t|
    t.integer  "sensor_id"
    t.integer  "hub_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hub_id"], name: "index_hub_sensors_on_hub_id", using: :btree
    t.index ["sensor_id"], name: "index_hub_sensors_on_sensor_id", using: :btree
  end

  create_table "hubs", force: :cascade do |t|
    t.text     "label"
    t.text     "friendly_id"
    t.text     "location"
    t.text     "ip"
    t.text     "hostname"
    t.text     "api_key"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["friendly_id"], name: "index_hubs_on_friendly_id", unique: true, using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.text     "file"
    t.datetime "started"
    t.datetime "completed"
    t.text     "status"
    t.integer  "duration"
    t.decimal  "progress"
    t.text     "status_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "printer_jobs", force: :cascade do |t|
    t.integer  "printer_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_printer_jobs_on_job_id", using: :btree
    t.index ["printer_id"], name: "index_printer_jobs_on_printer_id", using: :btree
  end

  create_table "printers", force: :cascade do |t|
    t.text     "label"
    t.text     "manufacturer"
    t.text     "model"
    t.text     "status"
    t.text     "friendly_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["friendly_id"], name: "index_printers_on_friendly_id", unique: true, using: :btree
  end

  create_table "sensor_data_points", force: :cascade do |t|
    t.integer  "sensor_id"
    t.integer  "data_point_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["data_point_id"], name: "index_sensor_data_points_on_data_point_id", using: :btree
    t.index ["sensor_id"], name: "index_sensor_data_points_on_sensor_id", using: :btree
  end

  create_table "sensors", force: :cascade do |t|
    t.text     "label"
    t.text     "category"
    t.text     "model"
    t.text     "manufacturer"
    t.text     "friendly_id"
    t.text     "desc"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["friendly_id"], name: "index_sensors_on_friendly_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
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
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

end
