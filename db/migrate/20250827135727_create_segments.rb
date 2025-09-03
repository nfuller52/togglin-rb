# frozen_string_literal: true

class CreateSegments < ActiveRecord::Migration[8.0]
  def change
    create_table :segments, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :context_kind, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
      t.text :name, null: false
      t.text :key, null: false
      t.jsonb :rule, null: false, default: {}
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :segments, %i[organization_id key], unique: true
  end
end
