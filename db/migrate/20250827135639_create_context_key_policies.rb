# frozen_string_literal: true

class CreateContextKeyPolicies < ActiveRecord::Migration[8.0]
  def change
    create_table :context_key_policies, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.text :algorithm, null: false, default: 'sha256'
      t.text :salt, null: false
      t.boolean :is_deterministic, null: false, default: true
      t.timestamps
      t.trackables
      t.soft_delete
    end
  end
end
