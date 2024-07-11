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

ActiveRecord::Schema[7.1].define(version: 2024_07_10_033437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedule_days", force: :cascade do |t|
    t.integer "day_of_week"
    t.bigint "client_service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_service_id"], name: "index_schedule_days_on_client_service_id"
  end

  create_table "schedule_time_ranges", force: :cascade do |t|
    t.integer "start_time_hour"
    t.integer "start_time_minute"
    t.integer "end_time_hour"
    t.integer "end_time_minute"
    t.bigint "schedule_day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_day_id"], name: "index_schedule_time_ranges_on_schedule_day_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.string "user_time_zone"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "client_service_id", null: false
    t.bigint "assigned_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_user_id"], name: "index_shifts_on_assigned_user_id"
    t.index ["client_service_id"], name: "index_shifts_on_client_service_id"
  end

  create_table "shifts_users", id: false, force: :cascade do |t|
    t.bigint "shift_id", null: false
    t.bigint "user_id", null: false
    t.index ["shift_id"], name: "index_shifts_users_on_shift_id"
    t.index ["user_id"], name: "index_shifts_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "schedule_days", "client_services"
  add_foreign_key "schedule_time_ranges", "schedule_days"
  add_foreign_key "shifts", "client_services"
  add_foreign_key "shifts", "users", column: "assigned_user_id"
end
