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

ActiveRecord::Schema.define(version: 20170718074153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "barcodes", force: :cascade do |t|
    t.string   "barcode"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "printed",    default: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "code"
    t.string   "barcode"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "taken",      default: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "department"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uuid"
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "document_id"
    t.datetime "expired_at"
    t.boolean  "closed",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "request_id"
    t.boolean  "checked",     default: false
    t.index ["document_id"], name: "index_entries_on_document_id", using: :btree
    t.index ["employee_id", "document_id"], name: "index_entries_on_employee_id_and_document_id", using: :btree
    t.index ["employee_id"], name: "index_entries_on_employee_id", using: :btree
    t.index ["request_id"], name: "index_entries_on_request_id", using: :btree
  end

  create_table "requests", force: :cascade do |t|
    t.boolean  "sent",        default: false
    t.boolean  "closed",      default: false
    t.integer  "employee_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["employee_id"], name: "index_requests_on_employee_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "entries", "documents"
  add_foreign_key "entries", "employees"
  add_foreign_key "entries", "requests"
  add_foreign_key "requests", "employees"
end
