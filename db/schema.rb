# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100620183551) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "commission_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proposals_count", :default => 0
  end

  create_table "opinions", :force => true do |t|
    t.string   "value"
    t.integer  "organization_id"
    t.integer  "proposal_id"
    t.text     "explanation"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "spokesman_id"
    t.string   "link"
  end

  create_table "proposals", :force => true do |t|
    t.string   "title",               :limit => 1024
    t.string   "official_url",        :limit => 1024
    t.string   "proposal_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "in_favor",                            :default => 0
    t.integer  "against",                             :default => 0
    t.integer  "abstention",                          :default => 0
    t.string   "official_resolution"
    t.integer  "category_id"
    t.integer  "proposer_id"
    t.date     "proposed_at"
    t.date     "closed_at"
    t.integer  "visits",                              :default => 0
    t.integer  "votes_count"
  end

  create_table "proposers", :force => true do |t|
    t.string   "name"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proposals_count", :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "login",                             :null => false
    t.string   "email",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.string   "perishable_token",                  :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "representer_id"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
