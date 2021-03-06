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

ActiveRecord::Schema.define(version: 20180409145419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "final_measures", force: :cascade do |t|
    t.string "operation"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "metric_id"
    t.boolean "is_final"
    t.date "collect_date"
    t.index ["metric_id"], name: "index_final_measures_on_metric_id"
  end

  create_table "measures", force: :cascade do |t|
    t.string "name"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.bigint "final_measure_id"
    t.string "operator"
    t.integer "metric"
    t.date "collect_date"
    t.index ["final_measure_id"], name: "index_measures_on_final_measure_id"
  end

  create_table "metrics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unit_of_measurement_id"
    t.string "scale"
    t.bigint "user_id"
    t.index ["unit_of_measurement_id"], name: "index_metrics_on_unit_of_measurement_id"
    t.index ["user_id"], name: "index_metrics_on_user_id"
  end

  create_table "unit_of_measurements", force: :cascade do |t|
    t.string "name"
    t.string "initials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_unit_of_measurements_on_user_id"
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

  add_foreign_key "final_measures", "metrics"
  add_foreign_key "measures", "final_measures"
  add_foreign_key "metrics", "unit_of_measurements"
  add_foreign_key "metrics", "users"
  add_foreign_key "unit_of_measurements", "users"
end
