# frozen_string_literal: true

class CreateContextSchemas < ActiveRecord::Migration[8.0]
  def change
    create_table :context_schemas, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :context_kind, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.integer :version
      t.jsonb :spec
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :context_schemas, %i[organization_id context_kind_id version], unique: true
  end
end
