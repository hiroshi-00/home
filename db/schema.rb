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

ActiveRecord::Schema.define(version: 2021_03_08_095458) do

  create_table "items", force: :cascade do |t|
    t.integer "no"
    t.string "name"
    t.string "image"
    t.integer "rarity"
    t.integer "weight"
    t.integer "max_lvl"
    t.integer "max_atck"
    t.integer "max_hp"
    t.integer "max_spd"
    t.integer "max_critical"
    t.integer "max_bullet"
    t.integer "fire_spd"
    t.integer "num_trajectories"
    t.integer "install_limit"
    t.integer "num_jumps"
    t.integer "closeness"
    t.string "skl_one"
    t.string "skl_one_element"
    t.string "skl_one_detail"
    t.string "skl_two"
    t.string "skl_two_element"
    t.string "skl_two_detail"
    t.string "skl_three"
    t.string "skl_three_detail"
    t.string "before_evl"
    t.string "after_evl"
    t.integer "kakusei"
    t.boolean "shop"
    t.boolean "gacha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
