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

ActiveRecord::Schema.define(version: 2021_11_08_170612) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "photographer_id", null: false
    t.bigint "photo_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["photo_id"], name: "index_likes_on_photo_id"
    t.index ["photographer_id"], name: "index_likes_on_photographer_id"
  end

  create_table "photographers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "city_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "slug"
    t.text "image_data"
    t.text "description"
    t.boolean "enabled", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_photographers_on_city_id"
    t.index ["slug"], name: "index_photographers_on_slug", unique: true
    t.index ["user_id"], name: "index_photographers_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "photographer_id", null: false
    t.bigint "category_id", null: false
    t.text "image_data"
    t.integer "likes_count", default: 0
    t.integer "views_count", default: 0
    t.boolean "enabled", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_photos_on_category_id"
    t.index ["photographer_id"], name: "index_photos_on_photographer_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", limit: 2
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "views", force: :cascade do |t|
    t.string "viewable_type", null: false
    t.bigint "viewable_id", null: false
    t.date "view_date"
    t.string "view_hash"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["viewable_type", "viewable_id"], name: "index_views_on_viewable"
  end

end
