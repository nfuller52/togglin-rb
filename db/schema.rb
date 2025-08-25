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

ActiveRecord::Schema[8.0].define(version: 2025_08_25_135451) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "enum_flag_dependency_edge_kinds", ["requires", "enables", "conflicts"]
  create_enum "enum_flag_kinds", ["boolean", "multivariate"]
  create_enum "enum_flag_set_purpose", ["runtime", "build", "test"]

  create_table "application_sdk_keys", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "application_id", null: false
    t.bigint "environment_id", null: false
    t.text "key", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_sdk_keys_on_application_id"
    t.index ["environment_id"], name: "index_application_sdk_keys_on_environment_id"
    t.index ["organization_id"], name: "index_application_sdk_keys_on_organization_id"
  end

  create_table "applications", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "default_flag_set_id", null: false
    t.text "name", null: false
    t.text "key", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["default_flag_set_id"], name: "index_applications_on_default_flag_set_id"
    t.index ["organization_id", "key"], name: "index_applications_on_organization_id_and_key", unique: true
    t.index ["organization_id"], name: "index_applications_on_organization_id"
  end

  create_table "environments", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "index_environments_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_environments_on_organization_id"
  end

  create_table "flag_bundles", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "environment_id", null: false
    t.bigint "flag_set_id", null: false
    t.integer "version", null: false
    t.jsonb "bundle", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "organization_id, environment_id, COALESCE(flag_set_id, (0)::bigint), version DESC", name: "idx_on_organization_id_environment_id_COALESCE_flag_8aad35eadd", unique: true
    t.index ["environment_id"], name: "index_flag_bundles_on_environment_id"
    t.index ["flag_set_id"], name: "index_flag_bundles_on_flag_set_id"
    t.index ["organization_id"], name: "index_flag_bundles_on_organization_id"
  end

  create_table "flag_dependencies", primary_key: ["organization_id", "parent_flag_id", "child_flag_id"], force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "parent_flag_id", null: false
    t.bigint "child_flag_id", null: false
    t.enum "edge_kind", null: false, enum_type: "enum_flag_dependency_edge_kinds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_flag_id"], name: "index_flag_dependencies_on_child_flag_id"
    t.index ["organization_id"], name: "index_flag_dependencies_on_organization_id"
    t.index ["parent_flag_id"], name: "index_flag_dependencies_on_parent_flag_id"
  end

  create_table "flag_dependency_closures", primary_key: ["organization_id", "ancestor_flag_id", "descendant_flag_id"], force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "ancestor_flag_id", null: false
    t.bigint "descendant_flag_id", null: false
    t.integer "depth", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestor_flag_id"], name: "index_flag_dependency_closures_on_ancestor_flag_id"
    t.index ["descendant_flag_id", "ancestor_flag_id"], name: "idx_on_descendant_flag_id_ancestor_flag_id_3928a71b9f"
    t.index ["descendant_flag_id"], name: "index_flag_dependency_closures_on_descendant_flag_id"
    t.index ["organization_id"], name: "index_flag_dependency_closures_on_organization_id"
    t.check_constraint "depth >= 1", name: "check_flag_dependency_closure_depth"
  end

  create_table "flag_environment_states", force: :cascade do |t|
    t.bigint "flag_id", null: false
    t.bigint "environment_id", null: false
    t.boolean "is_enabled", default: false, null: false
    t.text "default_variant_name"
    t.jsonb "rule_plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["environment_id"], name: "index_flag_environment_states_on_environment_id"
    t.index ["flag_id", "environment_id"], name: "index_flag_environment_states_on_flag_id_and_environment_id", unique: true
    t.index ["flag_id"], name: "index_flag_environment_states_on_flag_id"
  end

  create_table "flag_set_flags", primary_key: ["flag_id", "flag_set_id"], force: :cascade do |t|
    t.bigint "flag_id", null: false
    t.bigint "flag_set_id", null: false
    t.index ["flag_id"], name: "index_flag_set_flags_on_flag_id"
    t.index ["flag_set_id"], name: "index_flag_set_flags_on_flag_set_id"
  end

  create_table "flag_sets", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.text "name", null: false
    t.text "key", null: false
    t.enum "purpose", null: false, enum_type: "enum_flag_set_purpose"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "key"], name: "index_flag_sets_on_organization_id_and_key", unique: true
    t.index ["organization_id"], name: "index_flag_sets_on_organization_id"
  end

  create_table "flag_variants", force: :cascade do |t|
    t.bigint "flag_id", null: false
    t.text "name", null: false
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flag_id", "name"], name: "index_flag_variants_on_flag_id_and_name", unique: true
    t.index ["flag_id"], name: "index_flag_variants_on_flag_id"
    t.check_constraint "weight IS NULL OR weight >= 0 AND weight <= 100000", name: "check_flag_variant_weight"
  end

  create_table "flags", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.text "name", null: false
    t.text "key", null: false
    t.text "description"
    t.enum "kind", null: false, enum_type: "enum_flag_kinds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "key"], name: "index_flags_on_organization_id_and_key", unique: true
    t.index ["organization_id"], name: "index_flags_on_organization_id"
  end

  create_table "label_memberships", primary_key: ["label_id", "member_id"], force: :cascade do |t|
    t.bigint "label_id", null: false
    t.string "member_type", null: false
    t.bigint "member_id", null: false
    t.index ["label_id", "member_type", "member_id"], name: "idx_on_label_id_member_type_member_id_e286cff41a", unique: true
    t.index ["label_id"], name: "index_label_memberships_on_label_id"
    t.index ["member_type", "member_id"], name: "index_label_memberships_on_member"
    t.index ["member_type", "member_id"], name: "index_label_memberships_on_member_type_and_member_id"
  end

  create_table "labels", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.text "name", null: false
    t.text "description"
    t.text "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "index_labels_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_labels_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.text "name", null: false
    t.text "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  add_foreign_key "application_sdk_keys", "applications", on_delete: :cascade
  add_foreign_key "application_sdk_keys", "environments", on_delete: :restrict
  add_foreign_key "application_sdk_keys", "organizations", on_delete: :cascade
  add_foreign_key "applications", "flag_sets", column: "default_flag_set_id", on_delete: :nullify
  add_foreign_key "applications", "organizations", on_delete: :restrict
  add_foreign_key "environments", "organizations", on_delete: :restrict
  add_foreign_key "flag_bundles", "environments", on_delete: :restrict
  add_foreign_key "flag_bundles", "flag_sets", on_delete: :restrict
  add_foreign_key "flag_bundles", "organizations", on_delete: :restrict
  add_foreign_key "flag_dependencies", "flags", column: "child_flag_id", on_delete: :cascade
  add_foreign_key "flag_dependencies", "flags", column: "parent_flag_id", on_delete: :cascade
  add_foreign_key "flag_dependencies", "organizations", on_delete: :cascade
  add_foreign_key "flag_dependency_closures", "flags", column: "ancestor_flag_id", on_delete: :cascade
  add_foreign_key "flag_dependency_closures", "flags", column: "descendant_flag_id", on_delete: :cascade
  add_foreign_key "flag_dependency_closures", "organizations", on_delete: :cascade
  add_foreign_key "flag_environment_states", "environments"
  add_foreign_key "flag_environment_states", "flags", on_delete: :cascade
  add_foreign_key "flag_set_flags", "flag_sets", on_delete: :cascade
  add_foreign_key "flag_set_flags", "flags", on_delete: :cascade
  add_foreign_key "flag_sets", "organizations", on_delete: :restrict
  add_foreign_key "flag_variants", "flags", on_delete: :cascade
  add_foreign_key "flags", "organizations", on_delete: :restrict
  add_foreign_key "label_memberships", "labels", on_delete: :cascade
  add_foreign_key "labels", "organizations", on_delete: :cascade
end
