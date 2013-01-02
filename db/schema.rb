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

ActiveRecord::Schema.define(:version => 20130102181846) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "currency"
    t.text     "details"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "number"
    t.string   "processor"
  end

  create_table "allocations", :force => true do |t|
    t.integer  "amount"
    t.integer  "budget_id",      :null => false
    t.integer  "transaction_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "allocations", ["budget_id"], :name => "index_allocations_on_budget_id"
  add_index "allocations", ["transaction_id"], :name => "index_allocations_on_transaction_id"

  create_table "budgets", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "account_id",                     :null => false
    t.datetime "booking_date"
    t.integer  "amount",       :default => 0,    :null => false
    t.text     "details"
    t.boolean  "is_new",       :default => true, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "upload_id"
    t.integer  "remote_id"
  end

  add_index "transactions", ["account_id"], :name => "index_transactions_on_account_id"

  create_table "uploads", :force => true do |t|
    t.string   "filename",                        :null => false
    t.integer  "size"
    t.text     "contents"
    t.integer  "account_id",                      :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "checksum",                        :null => false
    t.boolean  "is_processed", :default => false, :null => false
  end

  add_index "uploads", ["account_id"], :name => "index_uploads_on_account_id"

end
