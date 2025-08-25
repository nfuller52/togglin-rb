class CreateFlagEnvironmentStates < ActiveRecord::Migration[8.0]
  def change
    create_table :flag_environment_states do |t|
      t.references :flag, null: false, foreign_key: { on_delete: :cascade }, index: true
      t.references :environment, null: false, foreign_key: true, index: true
      t.boolean :is_enabled, null: false, default: false
      t.text :default_variant_name
      t.jsonb :rule_plan
      t.timestamps
    end

    add_index :flag_environment_states, [:flag_id, :environment_id], unique: true
  end
end
