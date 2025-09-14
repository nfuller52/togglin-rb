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

ActiveRecord::Schema[8.0].define(version: 2025_08_27_135858) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "enum_flag_dependency_edge_kinds", ["requires", "enables", "conflicts"]
  create_enum "enum_flag_kinds", ["boolean", "multivariate"]
  create_enum "enum_flag_set_purpose", ["runtime", "build", "test"]
  create_enum "enum_token_kind", ["session", "personal_access_token", "access_token", "refresh", "password_reset", "email_confirmation", "magic_link_login", "email_change", "invite", "mfa_challenge", "environment_access"]

  create_table "application_sdk_keys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "application_id", null: false
    t.uuid "environment_id", null: false
    t.text "key", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.index ["application_id"], name: "index_application_sdk_keys_on_application_id"
    t.index ["environment_id"], name: "index_application_sdk_keys_on_environment_id"
    t.index ["organization_id"], name: "index_application_sdk_keys_on_organization_id"
  end

  create_table "applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "default_flag_set_id", null: false
    t.text "name", null: false
    t.text "key", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["default_flag_set_id"], name: "index_applications_on_default_flag_set_id"
    t.index ["organization_id", "key"], name: "index_applications_on_organization_id_and_key", unique: true
    t.index ["organization_id"], name: "index_applications_on_organization_id"
  end

  create_table "context_key_policies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.text "algorithm", default: "sha256", null: false
    t.text "salt", null: false
    t.boolean "is_deterministic", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["organization_id"], name: "index_context_key_policies_on_organization_id"
  end

  create_table "context_kinds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.text "key", null: false
    t.text "description"
    t.boolean "is_allowed_in_client_bundles", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["organization_id", "key"], name: "index_context_kinds_on_organization_id_and_key", unique: true
    t.index ["organization_id"], name: "index_context_kinds_on_organization_id"
  end

  create_table "context_schemas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "context_kind_id", null: false
    t.integer "version"
    t.jsonb "spec"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["context_kind_id"], name: "index_context_schemas_on_context_kind_id"
    t.index ["organization_id", "context_kind_id", "version"], name: "idx_on_organization_id_context_kind_id_version_b7c80e9551", unique: true
    t.index ["organization_id"], name: "index_context_schemas_on_organization_id"
  end

  create_table "environments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["organization_id", "name"], name: "index_environments_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_environments_on_organization_id"
  end

  create_table "flag_bundles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "environment_id", null: false
    t.uuid "flag_set_id"
    t.integer "version", null: false
    t.jsonb "bundle", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["environment_id"], name: "index_flag_bundles_on_environment_id"
    t.index ["flag_set_id"], name: "index_flag_bundles_on_flag_set_id"
    t.index ["organization_id", "environment_id", "flag_set_id", "version"], name: "idx_on_organization_id_environment_id_flag_set_id_v_8994316ef9", unique: true, order: { version: :desc }
    t.index ["organization_id"], name: "index_flag_bundles_on_organization_id"
  end

  create_table "flag_dependencies", primary_key: ["organization_id", "parent_flag_id", "child_flag_id"], force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "parent_flag_id", null: false
    t.uuid "child_flag_id", null: false
    t.enum "edge_kind", null: false, enum_type: "enum_flag_dependency_edge_kinds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["child_flag_id"], name: "index_flag_dependencies_on_child_flag_id"
    t.index ["organization_id"], name: "index_flag_dependencies_on_organization_id"
    t.index ["parent_flag_id"], name: "index_flag_dependencies_on_parent_flag_id"
  end

  create_table "flag_dependency_closures", primary_key: ["organization_id", "ancestor_flag_id", "descendant_flag_id"], force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "ancestor_flag_id", null: false
    t.uuid "descendant_flag_id", null: false
    t.integer "depth", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["ancestor_flag_id"], name: "index_flag_dependency_closures_on_ancestor_flag_id"
    t.index ["descendant_flag_id", "ancestor_flag_id"], name: "idx_on_descendant_flag_id_ancestor_flag_id_3928a71b9f"
    t.index ["descendant_flag_id"], name: "index_flag_dependency_closures_on_descendant_flag_id"
    t.index ["organization_id"], name: "index_flag_dependency_closures_on_organization_id"
    t.check_constraint "depth >= 1", name: "check_flag_dependency_closure_depth"
  end

  create_table "flag_environment_states", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "flag_id", null: false
    t.uuid "environment_id", null: false
    t.boolean "is_enabled", default: false, null: false
    t.text "default_variant_name"
    t.jsonb "rule_plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["environment_id"], name: "index_flag_environment_states_on_environment_id"
    t.index ["flag_id", "environment_id"], name: "index_flag_environment_states_on_flag_id_and_environment_id", unique: true
    t.index ["flag_id"], name: "index_flag_environment_states_on_flag_id"
  end

  create_table "flag_set_flags", primary_key: ["flag_id", "flag_set_id"], force: :cascade do |t|
    t.uuid "flag_id", null: false
    t.uuid "flag_set_id", null: false
    t.uuid "created_by_id", null: false
    t.index ["flag_id"], name: "index_flag_set_flags_on_flag_id"
    t.index ["flag_set_id"], name: "index_flag_set_flags_on_flag_set_id"
  end

  create_table "flag_sets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.text "name", null: false
    t.text "key", null: false
    t.enum "purpose", null: false, enum_type: "enum_flag_set_purpose"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["organization_id", "key"], name: "index_flag_sets_on_organization_id_and_key", unique: true
    t.index ["organization_id"], name: "index_flag_sets_on_organization_id"
  end

  create_table "flag_variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "flag_id", null: false
    t.text "name", null: false
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["flag_id", "name"], name: "index_flag_variants_on_flag_id_and_name", unique: true
    t.index ["flag_id"], name: "index_flag_variants_on_flag_id"
    t.check_constraint "weight IS NULL OR weight >= 0 AND weight <= 100000", name: "check_flag_variant_weight"
  end

  create_table "flags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.text "name", null: false
    t.text "key", null: false
    t.text "description"
    t.enum "kind", null: false, enum_type: "enum_flag_kinds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["organization_id", "key"], name: "index_flags_on_organization_id_and_key", unique: true
    t.index ["organization_id"], name: "index_flags_on_organization_id"
  end

  create_table "label_memberships", primary_key: ["label_id", "member_id"], force: :cascade do |t|
    t.uuid "label_id", null: false
    t.string "member_type", null: false
    t.uuid "member_id", null: false
    t.uuid "created_by_id", null: false
    t.index ["label_id", "member_type", "member_id"], name: "idx_on_label_id_member_type_member_id_e286cff41a", unique: true
    t.index ["label_id"], name: "index_label_memberships_on_label_id"
    t.index ["member_type", "member_id"], name: "index_label_memberships_on_member"
    t.index ["member_type", "member_id"], name: "index_label_memberships_on_member_type_and_member_id"
  end

  create_table "labels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.text "name", null: false
    t.text "description"
    t.text "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.index ["organization_id", "name"], name: "index_labels_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_labels_on_organization_id"
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "segment_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "segment_id", null: false
    t.text "stable_context_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["segment_id", "stable_context_key"], name: "index_segment_memberships_on_segment_id_and_stable_context_key", unique: true
    t.index ["segment_id"], name: "index_segment_memberships_on_segment_id"
  end

  create_table "segments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "context_kind_id", null: false
    t.text "name", null: false
    t.text "key", null: false
    t.jsonb "rule", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["context_kind_id"], name: "index_segments_on_context_kind_id"
    t.index ["organization_id", "key"], name: "index_segments_on_organization_id_and_key", unique: true
    t.index ["organization_id"], name: "index_segments_on_organization_id"
  end

  create_table "tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.enum "kind", null: false, enum_type: "enum_token_kind"
    t.string "resource_type", null: false
    t.uuid "resource_id", null: false
    t.text "token_digest", null: false
    t.text "token_prefix", null: false
    t.integer "max_uses", default: 1, null: false
    t.integer "use_count", default: 0, null: false
    t.datetime "expires_at"
    t.datetime "used_at"
    t.datetime "last_used_at"
    t.uuid "rotated_from_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by_id"
    t.uuid "updated_by_id"
    t.uuid "deleted_by_id"
    t.index ["resource_type", "resource_id", "kind"], name: "index_tokens_on_resource_type_and_resource_id_and_kind"
    t.index ["resource_type", "resource_id"], name: "index_tokens_on_resource"
    t.index ["rotated_from_id"], name: "index_tokens_on_rotated_from_id"
    t.index ["token_digest"], name: "index_tokens_on_token_digest", unique: true
    t.check_constraint "char_length(token_prefix) = 6"
  end

  create_table "user_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "ip_address"
    t.text "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.citext "email", null: false
    t.text "password_digest", null: false
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "deleted_by_id"
    t.datetime "deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "application_sdk_keys", "applications", on_delete: :cascade
  add_foreign_key "application_sdk_keys", "environments", on_delete: :restrict
  add_foreign_key "application_sdk_keys", "organizations", on_delete: :cascade
  add_foreign_key "application_sdk_keys", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "application_sdk_keys", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "application_sdk_keys", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "applications", "flag_sets", column: "default_flag_set_id", on_delete: :nullify
  add_foreign_key "applications", "organizations", on_delete: :restrict
  add_foreign_key "applications", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "applications", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "applications", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "context_key_policies", "organizations", on_delete: :cascade
  add_foreign_key "context_key_policies", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "context_key_policies", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "context_key_policies", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "context_kinds", "organizations", on_delete: :cascade
  add_foreign_key "context_kinds", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "context_kinds", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "context_kinds", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "context_schemas", "context_kinds", on_delete: :cascade
  add_foreign_key "context_schemas", "organizations", on_delete: :cascade
  add_foreign_key "context_schemas", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "context_schemas", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "context_schemas", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "environments", "organizations", on_delete: :restrict
  add_foreign_key "environments", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "environments", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "environments", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "flag_bundles", "environments", on_delete: :restrict
  add_foreign_key "flag_bundles", "flag_sets", on_delete: :restrict
  add_foreign_key "flag_bundles", "organizations", on_delete: :restrict
  add_foreign_key "flag_bundles", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "flag_bundles", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "flag_bundles", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "flag_dependencies", "flags", column: "child_flag_id", on_delete: :cascade
  add_foreign_key "flag_dependencies", "flags", column: "parent_flag_id", on_delete: :cascade
  add_foreign_key "flag_dependencies", "organizations", on_delete: :cascade
  add_foreign_key "flag_dependencies", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "flag_dependencies", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "flag_dependencies", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "flag_dependency_closures", "flags", column: "ancestor_flag_id", on_delete: :cascade
  add_foreign_key "flag_dependency_closures", "flags", column: "descendant_flag_id", on_delete: :cascade
  add_foreign_key "flag_dependency_closures", "organizations", on_delete: :cascade
  add_foreign_key "flag_dependency_closures", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "flag_dependency_closures", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "flag_dependency_closures", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "flag_environment_states", "environments"
  add_foreign_key "flag_environment_states", "flags", on_delete: :cascade
  add_foreign_key "flag_environment_states", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "flag_environment_states", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "flag_environment_states", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "flag_set_flags", "flag_sets", on_delete: :cascade
  add_foreign_key "flag_set_flags", "flags", on_delete: :cascade
  add_foreign_key "flag_set_flags", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "flag_sets", "organizations", on_delete: :restrict
  add_foreign_key "flag_sets", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "flag_sets", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "flag_sets", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "flag_variants", "flags", on_delete: :cascade
  add_foreign_key "flag_variants", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "flag_variants", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "flag_variants", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "flags", "organizations", on_delete: :restrict
  add_foreign_key "flags", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "flags", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "flags", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "label_memberships", "labels", on_delete: :cascade
  add_foreign_key "label_memberships", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "labels", "organizations", on_delete: :cascade
  add_foreign_key "labels", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "labels", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "labels", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "organizations", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "organizations", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "organizations", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "segment_memberships", "segments", on_delete: :cascade
  add_foreign_key "segment_memberships", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "segment_memberships", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "segment_memberships", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "segments", "context_kinds", on_delete: :restrict
  add_foreign_key "segments", "organizations", on_delete: :cascade
  add_foreign_key "segments", "users", column: "created_by_id", on_delete: :restrict
  add_foreign_key "segments", "users", column: "deleted_by_id", on_delete: :restrict
  add_foreign_key "segments", "users", column: "updated_by_id", on_delete: :restrict
  add_foreign_key "tokens", "tokens", column: "rotated_from_id"
  add_foreign_key "tokens", "users", column: "created_by_id", on_delete: :cascade
  add_foreign_key "tokens", "users", column: "deleted_by_id", on_delete: :cascade
  add_foreign_key "tokens", "users", column: "updated_by_id", on_delete: :cascade
  add_foreign_key "user_sessions", "users"
  add_foreign_key "users", "users", column: "deleted_by_id", on_delete: :restrict
end
