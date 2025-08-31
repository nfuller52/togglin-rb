class CreateSegments < ActiveRecord::Migration[8.0]
  def change
    create_table :segments do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.references :context_kind, null: false, foreign_key: { on_delete: :restrict }
      t.text :name, null: false
      t.text :key, null: false
      t.jsonb :rule, null: false, default: {}
      t.timestamps
    end

    add_index :segments, [:organization_id, :key], unique: true
  end
end
