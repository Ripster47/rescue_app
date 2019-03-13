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

ActiveRecord::Schema.define(version: 2019_03_13_170418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.text "description"
    t.boolean "adoptable"
    t.text "medical_status"
    t.integer "gender"
    t.string "age"
    t.string "image_url"
    t.decimal "donation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "animal_id"
    t.integer "purpose"
    t.integer "status"
    t.text "relinquish_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "phone_number"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "rent"
    t.boolean "children"
    t.boolean "adult"
    t.boolean "volunteer"
    t.boolean "foster"
    t.boolean "usark"
    t.boolean "exotic_vet"
    t.boolean "ever_owned"
    t.boolean "care"
    t.boolean "provisions"
    t.boolean "bequest"
    t.integer "accommodations"
    t.boolean "permit"
  end

end
