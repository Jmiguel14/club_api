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

ActiveRecord::Schema[8.0].define(version: 2026_03_29_120000) do
  create_schema "auth"
  create_schema "extensions"
  create_schema "graphql"
  create_schema "graphql_public"
  create_schema "pgbouncer"
  create_schema "realtime"
  create_schema "storage"
  create_schema "vault"

  # These are extensions that must be enabled in order to support this database
  enable_extension "extensions.pg_stat_statements"
  enable_extension "extensions.pgcrypto"
  enable_extension "extensions.uuid-ossp"
  enable_extension "graphql.pg_graphql"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vault.supabase_vault"

  create_table "apartments", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_apartments_on_email", unique: true
  end

  create_table "invoice_details", force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.bigint "product_id"
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 10, scale: 2
    t.decimal "point_cost", precision: 10, scale: 2
    t.string "type", default: "product", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.index ["invoice_id", "product_id"], name: "index_invoice_details_on_invoice_id_and_product_id", unique: true
    t.index ["invoice_id"], name: "index_invoice_details_on_invoice_id"
    t.index ["product_id"], name: "index_invoice_details_on_product_id"
    t.check_constraint "point_cost >= 0::numeric", name: "invoice_details_point_cost_non_negative"
    t.check_constraint "quantity > 0", name: "invoice_details_quantity_positive"
    t.check_constraint "type::text = ANY (ARRAY['product'::character varying, 'point'::character varying]::text[])", name: "invoice_details_type_valid"
    t.check_constraint "unit_price >= 0::numeric", name: "invoice_details_unit_price_non_negative"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "apartment_id", null: false
    t.date "issued_on", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apartment_id"], name: "index_invoices_on_apartment_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "sku", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "stock", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sku"], name: "index_products_on_sku", unique: true
    t.check_constraint "price >= 0::numeric", name: "products_price_non_negative"
    t.check_constraint "stock >= 0", name: "products_stock_non_negative"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "invoice_details", "invoices"
  add_foreign_key "invoice_details", "products"
  add_foreign_key "invoices", "apartments"
end
