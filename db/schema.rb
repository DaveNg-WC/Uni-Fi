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

<<<<<<< HEAD
ActiveRecord::Schema[7.0].define(version: 2023_03_21_091306) do
=======
ActiveRecord::Schema[7.0].define(version: 2023_03_19_085206) do
>>>>>>> master
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.decimal "amount", null: false
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "budgets_categories", id: false, force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.bigint "category_id", null: false
    t.index ["budget_id"], name: "index_budgets_categories_on_budget_id"
    t.index ["category_id"], name: "index_budgets_categories_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

<<<<<<< HEAD
  create_table "partners_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "partner_id"
    t.index ["partner_id"], name: "index_partners_users_on_partner_id"
    t.index ["user_id"], name: "index_partners_users_on_user_id"
=======
  create_table "partnerships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "partner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_partnerships_on_partner_id"
    t.index ["user_id"], name: "index_partnerships_on_user_id"
>>>>>>> master
  end

  create_table "transactions", force: :cascade do |t|
    t.text "description"
    t.string "type", null: false
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.decimal "amount", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "main_wallet_id", null: false
    t.bigint "second_wallet_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["main_wallet_id"], name: "index_transactions_on_main_wallet_id"
    t.index ["second_wallet_id"], name: "index_transactions_on_second_wallet_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "age"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.text "description"
    t.date "payment_due_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "budgets", "users"
  add_foreign_key "categories", "users"
<<<<<<< HEAD
  add_foreign_key "partners_users", "users"
=======
  add_foreign_key "partnerships", "users"
  add_foreign_key "partnerships", "users", column: "partner_id"
>>>>>>> master
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "users"
  add_foreign_key "transactions", "wallets", column: "main_wallet_id"
  add_foreign_key "transactions", "wallets", column: "second_wallet_id"
  add_foreign_key "wallets", "users"
end
