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

ActiveRecord::Schema.define(version: 20140919123053) do

  create_table "articles", force: true do |t|
    t.string   "body_html_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
  end

  create_table "contents", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
    t.integer  "content_variant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_variant_type"
  end

  create_table "time_line_items", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
    t.integer  "content_type", limit: 255, default: 0
    t.integer  "content_id"
    t.string   "content_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  create_table "videos", force: true do |t|
    t.string   "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
  end

end
