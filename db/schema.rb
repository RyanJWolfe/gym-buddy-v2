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

ActiveRecord::Schema[7.0].define(version: 2023_12_25_004824) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_instances", force: :cascade do |t|
    t.integer "reps"
    t.float "weight"
    t.text "notes"
    t.bigint "exercise_template_id", null: false
    t.bigint "workout_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_template_id"], name: "index_exercise_instances_on_exercise_template_id"
    t.index ["workout_id"], name: "index_exercise_instances_on_workout_id"
  end

  create_table "exercise_templates", force: :cascade do |t|
    t.string "name"
    t.string "muscle_group"
    t.string "equipment"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "workout_templates", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workout_templates_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.date "date"
    t.text "notes"
    t.integer "duration"
    t.bigint "user_id", null: false
    t.bigint "workout_template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
    t.index ["workout_template_id"], name: "index_workouts_on_workout_template_id"
  end

  add_foreign_key "exercise_instances", "exercise_templates"
  add_foreign_key "exercise_instances", "workouts"
  add_foreign_key "workout_templates", "users"
  add_foreign_key "workouts", "users"
  add_foreign_key "workouts", "workout_templates"
end
