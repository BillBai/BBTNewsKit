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

ActiveRecord::Schema.define(version: 20150201040803) do

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
    t.boolean  "active",              default: true
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
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
    t.boolean  "delete_flag",               default: false
    t.integer  "content_type"
    t.string   "video_url"
    t.integer  "parent_content_id",         default: 0
    t.boolean  "on_focus",                  default: false
    t.boolean  "display_on_timeline",       default: true
    t.integer  "user_id"
    t.integer  "publisher_id"
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

  create_table "publishers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  create_table "sections", force: true do |t|
    t.integer  "category"
    t.string   "module"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                     default: true
    t.string   "section_image_file_name"
    t.string   "section_image_content_type"
    t.integer  "section_image_file_size"
    t.datetime "section_image_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.integer  "group",                  default: 0
    t.integer  "passed_ids"
    t.integer  "publisher_id",           default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
