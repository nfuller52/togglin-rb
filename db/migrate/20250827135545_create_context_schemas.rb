class CreateContextSchemas < ActiveRecord::Migration[8.0]
  def change
    create_table :context_schemas do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.references :context_kind, null: false, foreign_key: { on_delete: :cascade }
      t.integer :version
      t.jsonb :spec
      t.timestamps
    end

    add_index :context_schemas, [:organization_id, :context_kind_id, :version], unique: true
  end
end
