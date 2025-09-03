# frozen_string_literal: true

class CreateContextKinds < ActiveRecord::Migration[8.0]
  def change
    create_table :context_kinds, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.text :key, null: false
      t.text :description
      t.boolean :is_allowed_in_client_bundles, null: false, default: true
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :context_kinds, %i[organization_id key], unique: true
  end
end
