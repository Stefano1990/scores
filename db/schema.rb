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

ActiveRecord::Schema.define(:version => 20140508095707) do

  create_table "cars", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "driver_bonus", :force => true do |t|
    t.integer  "driver_result_id"
    t.boolean  "pole"
    t.boolean  "fastest_lap"
    t.integer  "lap_led"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "driver_results", :force => true do |t|
    t.integer  "result_id"
    t.integer  "driver_id"
    t.integer  "fin_pos"
    t.integer  "car_id"
    t.string   "car"
    t.integer  "car_class_id"
    t.string   "car_class"
    t.integer  "cust_id"
    t.string   "name"
    t.integer  "start_pos"
    t.string   "car_nr"
    t.integer  "out_id"
    t.string   "out"
    t.integer  "laps_led",                        :default => 0
    t.integer  "fast_lap_nr"
    t.integer  "laps_comp",                       :default => 0
    t.integer  "inc",                             :default => 0
    t.integer  "league_points",                   :default => 0
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "interval",         :limit => nil
    t.string   "fastest_lap_time", :limit => nil
    t.string   "average_lap_time", :limit => nil
    t.integer  "bns_pts",                         :default => 0
    t.integer  "race_pts",                        :default => 0
    t.integer  "team_id"
    t.boolean  "fastest_lap"
    t.boolean  "lap_led"
    t.boolean  "pole_position"
  end

  create_table "driver_standing_graphics", :force => true do |t|
    t.integer  "standing_id"
    t.integer  "first_pos"
    t.integer  "last_pos"
    t.string   "image_name"
    t.string   "image_uid"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "driver_standings", :force => true do |t|
    t.integer  "standing_id"
    t.integer  "driver_id"
    t.integer  "tot_pts"
    t.integer  "race_pts"
    t.integer  "bns_pts"
    t.integer  "laps_comp"
    t.integer  "laps_led"
    t.integer  "inc"
    t.integer  "team_id"
    t.integer  "pos"
    t.integer  "penalty_pts"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "starts",      :default => 0
  end

  create_table "driver_team_connections", :force => true do |t|
    t.integer  "driver_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.integer  "customer_id"
  end

  create_table "graphics", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "background_name"
    t.string   "background_uid"
    t.text     "config"
    t.string   "preview_uid"
    t.string   "preview_name"
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "penalties", :force => true do |t|
    t.integer  "driver_result_id"
    t.boolean  "disqualification"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "one_sec"
    t.boolean  "two_sec"
    t.boolean  "three_sec"
    t.boolean  "five_sec"
    t.boolean  "ten_sec"
    t.boolean  "twenty_sec"
    t.boolean  "one_grid"
    t.boolean  "two_grid"
    t.boolean  "three_grid"
    t.boolean  "five_grid"
    t.boolean  "ten_grid"
    t.boolean  "thirty_sec"
  end

  create_table "point_systems", :force => true do |t|
    t.integer  "season_id"
    t.integer  "pts_1"
    t.integer  "pts_2"
    t.integer  "pts_3"
    t.integer  "pts_4"
    t.integer  "pts_5"
    t.integer  "pts_6"
    t.integer  "pts_7"
    t.integer  "pts_8"
    t.integer  "pts_9"
    t.integer  "pts_10"
    t.integer  "pts_11"
    t.integer  "pts_12"
    t.integer  "pts_13"
    t.integer  "pts_14"
    t.integer  "pts_15"
    t.integer  "pts_16"
    t.integer  "pts_17"
    t.integer  "pts_18"
    t.integer  "pts_19"
    t.integer  "pts_20"
    t.integer  "pts_21"
    t.integer  "pts_22"
    t.integer  "pts_23"
    t.integer  "pts_24"
    t.integer  "pts_25"
    t.integer  "pts_26"
    t.integer  "pts_27"
    t.integer  "pts_28"
    t.integer  "pts_29"
    t.integer  "pts_30"
    t.integer  "pts_31"
    t.integer  "pts_32"
    t.integer  "pts_33"
    t.integer  "pts_34"
    t.integer  "pts_35"
    t.integer  "pts_36"
    t.integer  "pts_37"
    t.integer  "pts_38"
    t.integer  "pts_39"
    t.integer  "pts_40"
    t.integer  "pts_41"
    t.integer  "pts_42"
    t.integer  "pts_43"
    t.integer  "pts_44"
    t.integer  "pts_45"
    t.integer  "pts_46"
    t.integer  "pts_47"
    t.integer  "pts_48"
    t.integer  "pts_49"
    t.integer  "pts_50"
    t.integer  "pts_51"
    t.integer  "pts_52"
    t.integer  "pts_53"
    t.integer  "pts_54"
    t.integer  "pts_55"
    t.integer  "pts_56"
    t.integer  "pts_57"
    t.integer  "pts_58"
    t.integer  "pts_59"
    t.integer  "pts_60"
    t.integer  "pts_61"
    t.integer  "pts_62"
    t.integer  "pts_63"
    t.integer  "pts_64"
    t.integer  "pts_65"
    t.integer  "pts_66"
    t.integer  "pts_67"
    t.integer  "pts_68"
    t.integer  "pts_69"
    t.integer  "pts_70"
    t.integer  "pts_71"
    t.integer  "pts_72"
    t.integer  "pts_73"
    t.integer  "pts_74"
    t.integer  "pts_75"
    t.integer  "pts_76"
    t.integer  "pts_77"
    t.integer  "pts_78"
    t.integer  "pts_79"
    t.integer  "pts_80"
    t.integer  "pts_81"
    t.integer  "pts_82"
    t.integer  "pts_83"
    t.integer  "pts_84"
    t.integer  "pts_85"
    t.integer  "pts_86"
    t.integer  "pts_87"
    t.integer  "pts_88"
    t.integer  "pts_89"
    t.integer  "pts_90"
    t.integer  "pts_91"
    t.integer  "pts_92"
    t.integer  "pts_93"
    t.integer  "pts_94"
    t.integer  "pts_95"
    t.integer  "pts_96"
    t.integer  "pts_97"
    t.integer  "pts_98"
    t.integer  "pts_99"
    t.integer  "pts_100"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "pole_position", :default => 0
    t.integer  "fastest_lap",   :default => 0
    t.integer  "lap_led",       :default => 0
  end

  create_table "races", :force => true do |t|
    t.integer  "season_id"
    t.date     "date"
    t.string   "name"
    t.time     "practice_start"
    t.time     "race_start"
    t.integer  "track_id"
    t.integer  "laps"
    t.time     "time"
    t.integer  "car_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "results", :force => true do |t|
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "status"
    t.string   "round"
    t.integer  "season_id"
    t.datetime "start_time"
    t.string   "track"
    t.string   "series"
    t.string   "hosted_session_name"
    t.string   "league_name"
    t.integer  "iracing_league_id"
    t.string   "league_season"
    t.integer  "league_season_id"
    t.string   "points_system"
  end

  create_table "seasons", :force => true do |t|
    t.integer  "series_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "background_uid"
    t.string   "background_name"
    t.string   "preview_uid"
    t.string   "preview_name"
    t.text     "config"
  end

  create_table "series", :force => true do |t|
    t.integer  "league_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "standing_configs", :force => true do |t|
    t.integer  "standing_id"
    t.string   "config_name"
    t.string   "config_uid"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "standings", :force => true do |t|
    t.integer "result_id"
    t.integer "season_id"
  end

  create_table "team_results", :force => true do |t|
    t.integer  "result_id"
    t.integer  "laps_led",      :default => 0
    t.integer  "laps_comp",     :default => 0
    t.integer  "inc",           :default => 0
    t.integer  "league_points", :default => 0
    t.integer  "race_pts",      :default => 0
    t.integer  "bns_pts",       :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "team_id"
    t.integer  "starts",        :default => 0
  end

  create_table "team_standing_graphics", :force => true do |t|
    t.integer  "standing_id"
    t.integer  "first_pos"
    t.integer  "last_pos"
    t.string   "image_name"
    t.string   "image_uid"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "team_standings", :force => true do |t|
    t.integer  "standing_id"
    t.integer  "team_id"
    t.integer  "tot_pts"
    t.integer  "race_pts"
    t.integer  "bns_pts"
    t.integer  "laps_comp"
    t.integer  "laps_led"
    t.integer  "inc"
    t.integer  "pos"
    t.integer  "penalty_pts"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "starts",      :default => 0
  end

  create_table "teams", :force => true do |t|
    t.integer  "season_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
