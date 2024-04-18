# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_18_184513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guesses", force: :cascade do |t|
    t.float "coord_x"
    t.float "coord_y"
    t.float "distance"
    t.boolean "is_successful"
    t.bigint "match_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_guesses_on_match_id"
    t.index ["user_id"], name: "index_guesses_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.float "treasure_x"
    t.float "treasure_y"
    t.float "closest_distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "winner_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "guesses", "matches"
  add_foreign_key "guesses", "users"
  add_foreign_key "matches", "users", column: "winner_id"
end
