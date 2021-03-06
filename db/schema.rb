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

ActiveRecord::Schema.define(version: 20140116141043) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "commission_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proposals_count", default: 0
  end

  create_table "delegated_votes", force: true do |t|
    t.integer  "proposal_id"
    t.integer  "in_favor",    default: 0
    t.integer  "against",     default: 0
    t.integer  "abstention",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", force: true do |t|
    t.string   "title",         limit: 1024
    t.string   "official_url",  limit: 1024
    t.string   "proposal_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "in_favor",                   default: 0
    t.integer  "against",                    default: 0
    t.integer  "abstention",                 default: 0
    t.string   "status"
    t.integer  "category_id"
    t.integer  "proposer_id"
    t.date     "proposed_at"
    t.date     "closed_at"
    t.integer  "visits",                     default: 0
    t.integer  "votes_count"
    t.integer  "closer_id"
    t.text     "body"
    t.integer  "api_id"
  end

  create_table "proposers", force: true do |t|
    t.string   "name"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proposals_count", default: 0
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "representer_id"
    t.string   "link"
    t.integer  "spokesman_id"
    t.integer  "represented_users_count", default: 0
    t.boolean  "admin",                   default: false
    t.string   "dni"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "nickname"
    t.string   "website_sink"
    t.string   "languages"
    t.string   "education"
    t.string   "twitter_link"
    t.string   "resume"
    t.string   "profile_picture"
    t.string   "twitter_user"
    t.string   "website_link"
    t.string   "other_link"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "explanation"
    t.string   "value"
  end

end
