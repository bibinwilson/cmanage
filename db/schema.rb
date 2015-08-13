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

ActiveRecord::Schema.define(version: 20150813090436) do

  create_table "containers", force: true do |t|
    t.integer  "host_id"
    t.integer  "image_id"
    t.string   "command"
    t.string   "created"
    t.string   "c_id"
    t.string   "image"
    t.string   "name"
    t.string   "ports"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "containers", ["host_id"], name: "index_containers_on_host_id", using: :btree
  add_index "containers", ["image_id"], name: "index_containers_on_image_id", using: :btree

  create_table "hosts", force: true do |t|
    t.string   "name"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.integer  "host_id"
    t.string   "image_id"
    t.string   "tags"
    t.datetime "created"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["host_id"], name: "index_images_on_host_id", using: :btree

end
