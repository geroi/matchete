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

ActiveRecord::Schema.define(version: 20160414000343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "text",            null: false
    t.integer  "messagable_id"
    t.integer  "author_id"
    t.string   "messagable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["messagable_type", "messagable_id"], name: "index_comments_on_messagable_type_and_messagable_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "friend_id"
    t.boolean  "approved",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["player_id"], name: "index_friendships_on_player_id", using: :btree

  create_table "game_teams", force: :cascade do |t|
    t.integer  "team_id",                        null: false
    t.integer  "game_id",                        null: false
    t.boolean  "approved",       default: false
    t.boolean  "host",           default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "host_initiated", default: false
    t.integer  "score",          default: 0
    t.integer  "tournament_id"
  end

  add_index "game_teams", ["game_id"], name: "index_game_teams_on_game_id", using: :btree
  add_index "game_teams", ["team_id"], name: "index_game_teams_on_team_id", using: :btree
  add_index "game_teams", ["tournament_id"], name: "index_game_teams_on_tournament_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.integer  "player_id"
    t.integer  "type_id"
    t.string   "playground_id"
    t.integer  "first_team_id"
    t.integer  "second_team_id"
    t.integer  "first_team_score",  default: 0
    t.integer  "second_team_score", default: 0
    t.datetime "game_date_time"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "individual",        default: true
  end

  add_index "games", ["first_team_id"], name: "index_games_on_first_team_id", using: :btree
  add_index "games", ["player_id"], name: "index_games_on_player_id", using: :btree
  add_index "games", ["playground_id"], name: "index_games_on_playground_id", using: :btree
  add_index "games", ["second_team_id"], name: "index_games_on_second_team_id", using: :btree

  create_table "player_games", force: :cascade do |t|
    t.integer "player_id"
    t.integer "game_id"
    t.boolean "approved",       default: false
    t.boolean "host_initiated", default: false
  end

  add_index "player_games", ["game_id"], name: "index_player_games_on_game_id", using: :btree
  add_index "player_games", ["player_id"], name: "index_player_games_on_player_id", using: :btree

  create_table "player_teams", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.boolean "host_initiated",  default: false
    t.boolean "approved",        default: false
    t.string  "position_name"
    t.integer "position_number"
  end

  add_index "player_teams", ["player_id"], name: "index_player_teams_on_player_id", using: :btree
  add_index "player_teams", ["team_id"], name: "index_player_teams_on_team_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "photo"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "playgrounds", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "hash_id"
    t.string   "lighting"
    t.string   "adm_area"
    t.string   "email"
    t.string   "facility_type"
    t.string   "district"
    t.string   "website"
    t.string   "phone"
    t.boolean  "has_rental",        default: false
    t.boolean  "has_dressing_room", default: false
    t.boolean  "has_toilet",        default: false
    t.boolean  "has_first_aid",     default: false
    t.string   "photo"
  end

  create_table "team_colors", force: :cascade do |t|
    t.integer "team_id",                     null: false
    t.string  "color",   default: "#ffffff"
  end

  add_index "team_colors", ["team_id"], name: "index_team_colors_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "type_id"
    t.integer  "host_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "address"
  end

  add_index "teams", ["host_id"], name: "index_teams_on_host_id", using: :btree
  add_index "teams", ["type_id"], name: "index_teams_on_type_id", using: :btree

  create_table "tournament_teams", force: :cascade do |t|
    t.integer  "tournament_id",             null: false
    t.integer  "team_id",                   null: false
    t.integer  "position"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "points",        default: 0
  end

  add_index "tournament_teams", ["team_id"], name: "index_tournament_teams_on_team_id", using: :btree
  add_index "tournament_teams", ["tournament_id"], name: "index_tournament_teams_on_tournament_id", using: :btree

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.integer  "host_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tournaments", ["host_id"], name: "index_tournaments_on_host_id", using: :btree

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "player_id"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["player_id"], name: "index_users_on_player_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
