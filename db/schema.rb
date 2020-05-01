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

ActiveRecord::Schema.define(version: 2020_04_23_184617) do

  create_table "courses", force: :cascade do |t|
    t.string "class_id"
    t.integer "section"
    t.string "component"
    t.string "days"
    t.time "start"
    t.time "end"
    t.string "location"
    t.string "professor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "grader"
    t.integer "gradersneeded"
    t.integer "gradersfilled"
  end

  create_table "evaluations", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.integer "dotnumber"
    t.string "class_id"
    t.string "email"
    t.integer "rating"
    t.string "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.string "section"
    t.string "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.boolean "preference"
    t.index ["student_id"], name: "index_grades_on_student_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.integer "dotnumber"
    t.string "class_id"
    t.integer "section"
    t.string "component"
    t.string "days"
    t.time "start"
    t.time "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "requests", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.integer "dotnumber"
    t.string "class_id"
    t.integer "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "students", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.integer "dotnumber"
    t.time "mondaystart"
    t.time "mondayend"
    t.time "tuesdaystart"
    t.time "tuesdayend"
    t.time "wednesdaystart"
    t.time "wednesdayend"
    t.time "thursdaystart"
    t.time "thursdayend"
    t.time "fridaystart"
    t.time "fridayend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.boolean "teacher", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
