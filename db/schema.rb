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

ActiveRecord::Schema[7.0].define(version: 2022_02_22_032652) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["phone"], name: "index_admins_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "courses", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "instructor_name"
    t.string "weekday1"
    t.string "weekday2"
    t.time "start_time"
    t.time "end_time"
    t.integer "capacity"
    t.integer "waitlist_capacity"
    t.string "status", default: "OPEN"
    t.string "room"
    t.bigint "instructor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "enrolled", default: 0
    t.integer "wait_listed", default: 0
    t.index ["code"], name: "index_courses_on_code", unique: true
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
  end

  create_table "enrolls", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "course_id", null: false
    t.string "student_id", null: false
    t.boolean "waitlist", default: false
  end

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.string "department"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_instructors_on_email", unique: true
    t.index ["name"], name: "index_instructors_on_name", unique: true
    t.index ["reset_password_token"], name: "index_instructors_on_reset_password_token", unique: true
  end

  create_table "students", primary_key: "student_id", id: :string, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.date "dob", null: false
    t.string "phone", null: false
    t.string "major", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["phone"], name: "index_students_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "instructors"
  add_foreign_key "enrolls", "courses", primary_key: "code", on_delete: :cascade
  add_foreign_key "enrolls", "students", primary_key: "student_id", on_delete: :cascade
end
