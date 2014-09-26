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

ActiveRecord::Schema.define(version: 20140926142815) do

  create_table "article_body_images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "body_image_file_name"
    t.string   "body_image_content_type"
    t.integer  "body_image_file_size"
    t.datetime "body_image_updated_at"
    t.integer  "content_id"
  end

  create_table "authors", force: true do |t|
    t.integer  "department"
    t.string   "name"
    t.string   "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  create_table "contents", force: true do |t|
    t.string   "body_html_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
    t.integer  "author_id"
    t.integer  "section_id"
    t.string   "header_image_file_name"
    t.string   "header_image_content_type"
    t.integer  "header_image_file_size"
    t.datetime "header_image_updated_at"
    t.string   "header_image_info"
    t.text     "body_html"
    t.integer  "status"
    t.boolean  "delete_flag"
    t.integer  "content_type"
    t.string   "video_url"
  end

  create_table "photos", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "photographer"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["content_id"], name: "index_photos_on_content_id"

  create_table "sections", force: true do |t|
    t.integer  "category"
    t.string   "module"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

end
