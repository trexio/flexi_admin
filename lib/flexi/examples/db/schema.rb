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

ActiveRecord::Schema[7.1].define(version: 2024_09_12_130913) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "elements", force: :cascade do |t|
    t.string "name"
    t.bigint "playground_id", null: false
    t.float "lat"
    t.float "lng"
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_archived", default: false
    t.index ["playground_id"], name: "index_elements_on_playground_id"
  end

  create_table "inspected_elements", force: :cascade do |t|
    t.bigint "element_id", null: false
    t.bigint "inspection_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "comment"
    t.boolean "is_archived", default: false
    t.index ["element_id", "inspection_id"], name: "index_inspected_elements_on_element_id_and_inspection_id", unique: true
    t.index ["element_id"], name: "index_inspected_elements_on_element_id"
    t.index ["inspection_id"], name: "index_inspected_elements_on_inspection_id"
  end

  create_table "inspections", force: :cascade do |t|
    t.string "number"
    t.string "status"
    t.string "inspector"
    t.date "inspection_date"
    t.string "recommended_documentation"
    t.string "other_recommendations"
    t.string "other_defects"
    t.string "safety_management_system_status"
    t.string "declaration"
    t.bigint "playground_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expires_at"
    t.string "kind"
    t.string "norms"
    t.index ["playground_id"], name: "index_inspections_on_playground_id"
  end

  create_table "observation_images", force: :cascade do |t|
    t.bigint "inspection_id"
    t.bigint "observation_id"
    t.bigint "inspected_element_id"
    t.jsonb "exif_data"
    t.datetime "taken_at"
    t.float "lat"
    t.float "lng"
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_archived", default: false
    t.index ["inspected_element_id"], name: "index_observation_images_on_inspected_element_id"
    t.index ["inspection_id"], name: "index_observation_images_on_inspection_id"
    t.index ["observation_id"], name: "index_observation_images_on_observation_id"
  end

  create_table "observations", force: :cascade do |t|
    t.string "description"
    t.string "remedy"
    t.boolean "excluded_from_service"
    t.bigint "inspected_element_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspected_element_id"], name: "index_observations_on_inspected_element_id"
  end

  create_table "playground_status_templates", force: :cascade do |t|
    t.string "group", null: false
    t.string "name", null: false
    t.string "source"
    t.string "status"
    t.jsonb "aliases", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playground_statuses", force: :cascade do |t|
    t.bigint "inspection_id", null: false
    t.bigint "playground_status_template_id", null: false
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspection_id"], name: "index_playground_statuses_on_inspection_id"
    t.index ["playground_status_template_id"], name: "index_playground_statuses_on_playground_status_template_id"
  end

  create_table "playgrounds", force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "lng"
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "address"
    t.string "google_place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "protocol_migrations", force: :cascade do |t|
    t.bigint "playground_id"
    t.bigint "inspection_id"
    t.jsonb "data"
    t.jsonb "issues"
    t.integer "errors_count", default: 0
    t.datetime "migrated_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspection_id"], name: "index_protocol_migrations_on_inspection_id"
    t.index ["playground_id", "inspection_id"], name: "index_protocol_migrations_on_playground_and_inspection", unique: true
    t.index ["playground_id"], name: "index_protocol_migrations_on_playground_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "elements", "playgrounds"
  add_foreign_key "inspected_elements", "elements"
  add_foreign_key "inspected_elements", "inspections"
  add_foreign_key "inspections", "playgrounds"
  add_foreign_key "observation_images", "inspected_elements"
  add_foreign_key "observation_images", "inspections"
  add_foreign_key "observation_images", "observations"
  add_foreign_key "observations", "inspected_elements"
  add_foreign_key "playground_statuses", "inspections"
  add_foreign_key "playground_statuses", "playground_status_templates"
  add_foreign_key "protocol_migrations", "inspections"
  add_foreign_key "protocol_migrations", "playgrounds"
end
