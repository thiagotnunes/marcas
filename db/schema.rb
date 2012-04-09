# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120409180003) do

  create_table "invoices", :force => true do |t|
  end

  create_table "order_attachments", :force => true do |t|
    t.string   "file"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "trademark_order_id"
  end

  add_index "order_attachments", ["trademark_order_id"], :name => "index_order_attachments_on_trademark_order_id"

  create_table "order_statuses", :force => true do |t|
    t.string   "status"
    t.text     "description"
    t.string   "color"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "lifecycle"
  end

  create_table "order_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "order_status_id"
    t.integer  "service_id"
    t.integer  "invoice_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.integer  "order_type_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "services", ["order_type_id"], :name => "index_services_on_order_type_id"

  create_table "trademark_orders", :force => true do |t|
    t.string   "name"
    t.string   "segment"
    t.string   "subsegment"
    t.text     "observations"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.integer  "service_id"
    t.integer  "order_status_id"
    t.integer  "invoice_id"
  end

  add_index "trademark_orders", ["invoice_id"], :name => "index_trademark_orders_on_invoice_id"
  add_index "trademark_orders", ["order_status_id"], :name => "index_trademark_orders_on_order_status_id"
  add_index "trademark_orders", ["service_id"], :name => "index_trademark_orders_on_service_id"
  add_index "trademark_orders", ["user_id"], :name => "index_trademark_orders_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "role"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
