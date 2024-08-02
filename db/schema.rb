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

ActiveRecord::Schema[7.1].define(version: 20_240_729_112_144) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'customers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id', null: false
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'mobile_number'
    t.string 'address'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_customers_on_user_id'
  end

  create_table 'products', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id', null: false
    t.string 'name', null: false
    t.integer 'price', null: false
    t.integer 'cost'
    t.integer 'quantity'
    t.boolean 'inventory', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_products_on_user_id'
  end

  create_table 'purchase_orders', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id', null: false
    t.uuid 'customer_id', null: false
    t.uuid 'product_id', null: false
    t.integer 'quantity'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['customer_id'], name: 'index_purchase_orders_on_customer_id'
    t.index ['product_id'], name: 'index_purchase_orders_on_product_id'
    t.index ['user_id'], name: 'index_purchase_orders_on_user_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'customers', 'users'
  add_foreign_key 'products', 'users'
  add_foreign_key 'purchase_orders', 'customers'
  add_foreign_key 'purchase_orders', 'products'
  add_foreign_key 'purchase_orders', 'users'
end
