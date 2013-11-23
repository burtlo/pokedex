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

ActiveRecord::Schema.define(version: 20131123212707) do

  create_table "moves", force: true do |t|
    t.integer  "level"
    t.string   "name"
    t.integer  "type_id"
    t.string   "category"
    t.integer  "attack"
    t.integer  "accuracy"
    t.integer  "points"
    t.integer  "effect_percent"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "moves", ["type_id"], name: "index_moves_on_type_id"

  create_table "pokemon_evolutions", force: true do |t|
    t.integer  "pokemon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "evolves_to"
    t.text     "event"
  end

  add_index "pokemon_evolutions", ["pokemon_id"], name: "index_pokemon_evolutions_on_pokemon_id"

  create_table "pokemon_moves", force: true do |t|
    t.integer  "pokemon_id"
    t.integer  "move_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pokemon_moves", ["move_id"], name: "index_pokemon_moves_on_move_id"
  add_index "pokemon_moves", ["pokemon_id"], name: "index_pokemon_moves_on_pokemon_id"

  create_table "pokemon_types", force: true do |t|
    t.integer  "pokemon_id"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pokemon_types", ["pokemon_id"], name: "index_pokemon_types_on_pokemon_id"
  add_index "pokemon_types", ["type_id"], name: "index_pokemon_types_on_type_id"

  create_table "pokemons", force: true do |t|
    t.integer  "index"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_damage_multipliers", force: true do |t|
    t.string   "type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "multipliers"
  end

  create_table "type_effects", force: true do |t|
    t.integer  "type_id"
    t.integer  "other_type_id"
    t.float    "multiplier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "type_effects", ["type_id"], name: "index_type_effects_on_type_id"

  create_table "types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
