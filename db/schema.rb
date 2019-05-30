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

ActiveRecord::Schema.define(version: 2019_05_29_104451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "number_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "status_crawls", force: :cascade do |t|
    t.string "current_status", default: "new"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tallent_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tallent_categories_on_category_id"
    t.index ["user_id"], name: "index_tallent_categories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "_id"
    t.string "name"
    t.string "username"
    t.float "engagement_speed"
    t.float "engagement_volume"
    t.float "engagement_score"
    t.text "firstOrderCompletedAt"
    t.float "averageMillisecondsToComplete"
    t.text "imageUrl"
    t.text "imageUrlKey"
    t.integer "numOfRatings"
    t.float "averageRating"
    t.float "price"
    t.text "profession"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["_id"], name: "index_users_on__id"
  end

end
