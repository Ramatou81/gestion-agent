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

ActiveRecord::Schema[8.0].define(version: 2025_08_27_150852) do
  create_table "agents", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "email", null: false
    t.string "phone"
    t.date "birth_date"
    t.string "address"
    t.string "position"
    t.date "hire_date"
    t.string "status", default: "active"
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.index ["department_id"], name: "index_agents_on_department_id"
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["manager_id"], name: "index_agents_on_manager_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "agent_id", null: false
    t.string "status"
    t.datetime "check_in"
    t.datetime "check_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "hours"
    t.index ["agent_id"], name: "index_attendances_on_agent_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_departments_on_manager_id"
  end

  create_table "leave_requests", force: :cascade do |t|
    t.integer "agent_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["agent_id"], name: "index_leave_requests_on_agent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 2, null: false
    t.integer "agent_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "department_id"
    t.string "phone"
    t.string "address"
    t.date "birth_date"
    t.date "hire_date"
    t.integer "manager_id"
    t.index ["agent_id"], name: "index_users_on_agent_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["manager_id"], name: "index_users_on_manager_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "agents", "agents", column: "manager_id"
  add_foreign_key "agents", "departments"
  add_foreign_key "attendances", "agents"
  add_foreign_key "departments", "agents", column: "manager_id"
  add_foreign_key "leave_requests", "agents"
  add_foreign_key "users", "agents"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "users", column: "manager_id"
end
