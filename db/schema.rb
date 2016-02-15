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

ActiveRecord::Schema.define(version: 20160215210127) do

  create_table "jobs", force: :cascade do |t|
    t.string   "status"
    t.string   "progress"
    t.string   "creator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "printers", force: :cascade do |t|
    t.string   "make"
    t.string   "jobs"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "printjobs", force: :cascade do |t|
    t.string   "status"
    t.string   "progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sensordata", force: :cascade do |t|
    t.string   "type"
    t.string   "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.string   "type"
    t.string   "data"
    t.string   "desc"
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
