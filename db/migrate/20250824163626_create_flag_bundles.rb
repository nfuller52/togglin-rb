class CreateFlagBundles < ActiveRecord::Migration[8.0]
  def change
    create_table :flag_bundles do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :restrict }, index: true
      t.references :environment, null: false, foreign_key: { on_delete: :restrict }, index: true
      t.references :flag_set, null: false, foreign_key: { on_delete: :restrict }, index: true
      t.integer :version, null: false
      t.jsonb :bundle, null: false
      t.timestamps
    end

    add_index :flag_bundles, "organization_id, environment_id, COALESCE(flag_set_id, 0), version DESC", unique: true
  end
end
