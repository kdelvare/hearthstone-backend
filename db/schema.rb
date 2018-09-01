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

ActiveRecord::Schema.define(version: 20180828194337) do

  create_table "cardclasses", primary_key: "hs_id", force: :cascade do |t|
    t.string "name"
    t.string "name_fr"
    t.boolean "collectible"
    t.integer "card_id"
  end

  create_table "cards", primary_key: "hs_id", force: :cascade do |t|
    t.string "hs_card_id"
    t.string "name"
    t.string "name_fr"
    t.string "cardtext"
    t.string "cardtext_fr"
    t.text "flavor"
    t.text "flavor_fr"
    t.string "artist"
    t.integer "cost"
    t.integer "health"
    t.integer "atk"
    t.integer "cardset_id"
    t.integer "cardclass_id"
    t.integer "type_id"
    t.integer "rarity_id"
  end

  create_table "cardsets", primary_key: "hs_id", force: :cascade do |t|
    t.string "name"
    t.string "name_fr"
    t.boolean "collectible"
    t.boolean "standard"
  end

  create_table "collections", force: :cascade do |t|
    t.integer "user_id"
    t.integer "card_id"
    t.integer "number"
  end

  create_table "deckcards", force: :cascade do |t|
    t.integer "deck_id"
    t.integer "card_id"
    t.integer "number"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "cardclass_id"
  end

  create_table "rarities", primary_key: "hs_id", force: :cascade do |t|
    t.string "name"
    t.string "name_fr"
    t.boolean "collectible"
  end

  create_table "types", primary_key: "hs_id", force: :cascade do |t|
    t.string "name"
    t.string "name_fr"
    t.boolean "collectible"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
