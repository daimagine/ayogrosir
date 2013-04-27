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

ActiveRecord::Schema.define(:version => 20130427081150) do

  create_table "advertises", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "title"
    t.string   "description"
    t.string   "adv_type"
    t.string   "status",           :default => "A"
    t.integer  "sequence",         :default => 0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.text     "content"
    t.string   "post_status",      :default => "draft"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "cat_type",   :default => "Store"
  end

  create_table "counters", :force => true do |t|
    t.string   "ip_address"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "markets", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "postal_code"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "logo_img"
    t.text     "description"
    t.text     "info1"
    t.integer  "page_view",   :default => 0
    t.string   "status"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "menus", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "url"
    t.integer  "sequence",   :default => 0
    t.integer  "parent_id",  :default => 0
    t.string   "status",     :default => "A"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "parent",     :default => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "slug",                          :null => false
    t.text     "content",                       :null => false
    t.integer  "page_view",  :default => 0
    t.string   "status",     :default => "A"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "static",     :default => false
    t.string   "template"
  end

  create_table "preferences", :force => true do |t|
    t.string   "pref_key",                     :null => false
    t.string   "pref_value"
    t.string   "name"
    t.string   "description"
    t.string   "status",      :default => "A"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "product_categories", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "products", :force => true do |t|
    t.integer  "store_id"
    t.string   "name",                                                           :null => false
    t.decimal  "price",            :precision => 14, :scale => 2,                :null => false
    t.string   "logo_img"
    t.text     "description"
    t.text     "info1"
    t.integer  "page_view",                                       :default => 0
    t.string   "status"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.float    "weight"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "search_stores", :force => true do |t|
    t.string   "keywords"
    t.integer  "market_id"
    t.integer  "category_id"
    t.string   "order_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "store_categories", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "store_id"
  end

  create_table "store_follow", :force => true do |t|
    t.integer "user_id"
    t.integer "store_id"
  end

  add_index "store_follow", ["user_id", "store_id"], :name => "index_store_follow_on_user_id_and_store_id"

  create_table "stores", :force => true do |t|
    t.integer  "market_id"
    t.string   "name",                            :null => false
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "postal_code"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "logo_img"
    t.text     "description"
    t.text     "info1"
    t.integer  "page_view",        :default => 0
    t.string   "status"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "info2"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "user_type",              :default => "member"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
