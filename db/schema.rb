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

ActiveRecord::Schema.define(version: 20131026210845) do

  create_table "criteria", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scorecards", force: true do |t|
    t.string   "url"
    t.integer  "grader_id"
    t.integer  "gradee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scorecards", ["gradee_id"], name: "index_scorecards_on_gradee_id", using: :btree
  add_index "scorecards", ["grader_id", "gradee_id"], name: "index_scorecards_on_grader_id_and_gradee_id", using: :btree
  add_index "scorecards", ["grader_id"], name: "index_scorecards_on_grader_id", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "criterium_id"
    t.integer  "scorecard_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["criterium_id"], name: "index_scores_on_criterium_id", using: :btree
  add_index "scores", ["scorecard_id"], name: "index_scores_on_scorecard_id", using: :btree

  create_table "user_criteria", force: true do |t|
    t.integer  "criterium_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_criteria", ["criterium_id"], name: "index_user_criteria_on_criterium_id", using: :btree
  add_index "user_criteria", ["user_id"], name: "index_user_criteria_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.string   "slug"
    t.boolean  "disabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link_hash"
    t.string   "session_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

end
