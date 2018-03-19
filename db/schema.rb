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

ActiveRecord::Schema.define(version: 20180319223602) do

  create_table "final_measures", force: :cascade do |t|
    t.string "operation"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "metric_id"
    t.index ["metric_id"], name: "index_final_measures_on_metric_id"
  end

  create_table "measures", force: :cascade do |t|
    t.string "name"
    t.float "value"
    t.date "collection_date"
    t.string "scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_of_measurement_id"
    t.integer "position"
    t.integer "final_measure_id"
    t.string "operator"
    t.integer "metric"
    t.index ["final_measure_id"], name: "index_measures_on_final_measure_id"
    t.index ["unit_of_measurement_id"], name: "index_measures_on_unit_of_measurement_id"
  end

  create_table "metrics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unit_of_measurements", force: :cascade do |t|
    t.string "name"
    t.string "initials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
