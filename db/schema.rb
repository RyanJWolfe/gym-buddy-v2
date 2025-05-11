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

ActiveRecord::Schema[8.0].define(version: 2025_05_11_003610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "exercise_logs", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.text "notes"
    t.string "equipment_brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_logs_on_exercise_id"
    t.index ["workout_id", "exercise_id"], name: "index_exercise_logs_on_workout_id_and_exercise_id"
    t.index ["workout_id"], name: "index_exercise_logs_on_workout_id"
  end

  create_table "exercise_sets", force: :cascade do |t|
    t.bigint "exercise_log_id", null: false
    t.integer "set_number", null: false
    t.integer "reps", null: false
    t.decimal "weight", precision: 8, scale: 2, null: false
    t.integer "rest_seconds"
    t.integer "duration_seconds"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_log_id", "set_number"], name: "index_exercise_sets_on_exercise_log_id_and_set_number"
    t.index ["exercise_log_id"], name: "index_exercise_sets_on_exercise_log_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name", null: false
    t.string "category", null: false
    t.string "equipment_type", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_exercises_on_category"
    t.index ["equipment_type"], name: "index_exercises_on_equipment_type"
    t.index ["name"], name: "index_exercises_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "workout_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.date "date", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "status", default: 1
    t.bigint "template_id"
    t.string "template_name"
    t.index ["date"], name: "index_workouts_on_date"
    t.index ["template_id"], name: "index_workouts_on_template_id"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "exercise_logs", "exercises"
  add_foreign_key "exercise_logs", "workouts"
  add_foreign_key "exercise_sets", "exercise_logs"
  add_foreign_key "workouts", "users"
  add_foreign_key "workouts", "workouts", column: "template_id"
end
