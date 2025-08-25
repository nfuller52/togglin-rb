class CreateFlagDependencies < ActiveRecord::Migration[8.0]
  def change
    create_enum :enum_flag_dependency_edge_kinds, %w[requires enables conflicts]

    create_table :flag_dependencies, primary_key: [:organization_id, :parent_flag_id, :child_flag_id] do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }, index: true
      t.references :parent_flag, null: false, foreign_key: { to_table: :flags, on_delete: :cascade }, index: true
      t.references :child_flag, null: false, foreign_key: { to_table: :flags, on_delete: :cascade }, index: true
      t.column :edge_kind, :enum_flag_dependency_edge_kinds, null: false
      t.timestamps
    end
  end
end
