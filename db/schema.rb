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

ActiveRecord::Schema.define(version: 20140501045300) do

  create_table "comments", force: true do |t|
    t.integer  "author_id"
    t.integer  "post_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["author_id", "updated_at"], name: "index_comments_on_author_id_and_updated_at", using: :btree
  add_index "comments", ["post_id", "updated_at"], name: "index_comments_on_post_id_and_updated_at", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.datetime "read_at"
    t.boolean  "is_read",     default: false, null: false
    t.string   "detail_path"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id", "is_read", "read_at"], name: "index_notifications_on_user_id_and_is_read_and_read_at", using: :btree

  create_table "post_tags", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_tags", ["post_id"], name: "index_post_tags_on_post_id", using: :btree
  add_index "post_tags", ["tag_id"], name: "index_post_tags_on_tag_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_draft",       default: false
    t.date     "specified_date"
  end

  add_index "posts", ["is_draft"], name: "index_posts_on_is_draft", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.text     "body"
    t.integer  "posts_count", default: 0, null: false
  end

  add_index "tags", ["ancestry"], name: "index_tags_on_ancestry", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "google_auth_token"
    t.string   "google_refresh_token"
    t.datetime "google_token_expires_at"
    t.string   "nickname",                default: "", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
