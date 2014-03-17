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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140316114615) do

  create_table "drivers", :force => true do |t|
    t.integer  "pos"
    t.integer  "league_id"
    t.string   "name"
    t.string   "team"
    t.integer  "starts"
    t.integer  "wins"
    t.integer  "top5"
    t.integer  "top10"
    t.integer  "tot_pts"
    t.integer  "bns_pts"
    t.integer  "laps"
    t.integer  "beh_lead"
    t.integer  "beh_next"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "race_pts"
    t.string   "interval"
    t.integer  "laps_led"
    t.string   "fastest_lap"
    t.integer  "fast_lap"
    t.string   "avg_lap"
    t.integer  "inc"
    t.string   "status"
  end

  create_table "league_configs", :force => true do |t|
    t.integer  "league_id"
    t.string   "config_name"
    t.string   "config_uid"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "background_name"
    t.string   "background_uid"
    t.text     "config"
  end

  create_table "results", :force => true do |t|
    t.integer  "league_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image_name"
    t.string   "image_uid"
    t.string   "url"
    t.string   "status"
  end

  create_table "standing_configs", :force => true do |t|
    t.integer  "standing_id"
    t.string   "config_name"
    t.string   "config_uid"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "standings", :force => true do |t|
    t.integer  "league_id"
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "url"
    t.string   "status"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
