# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[8.0]
  def change
    create_enum :enum_token_kind, %w[
      session
      personal_access_token
      access_token
      refresh
      password_reset
      email_confirmation
      magic_link_login
      email_change
      invite
      mfa_challenge
      environment_access
    ]

    create_table :tokens, id: :uuid do |t|
      t.enum :kind, enum_type: :enum_token_kind, null: false
      t.references :resource, type: :uuid, null: false, polymorphic: true
      t.text :token_digest, null: false
      t.text :token_prefix, null: false
      t.integer :max_uses, null: false, default: 1
      t.integer :use_count, null: false, default: 0
      t.datetime :expires_at
      t.datetime :used_at
      t.datetime :last_used_at
      t.references :rotated_from, type: :uuid, null: false, foreign_key: { to_table: :tokens }
      t.timestamps
      t.trackables null: true, on_delete: :cascade
    end

    add_index :tokens, :token_digest, unique: true
    add_index :tokens, %i[resource_type resource_id kind]

    add_check_constraint :tokens, 'char_length(token_prefix) = 6'
  end
end
