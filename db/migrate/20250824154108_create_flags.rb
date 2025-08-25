class CreateFlags < ActiveRecord::Migration[8.0]
  def change
    create_enum :enum_flag_kinds, %w[boolean multivariate]

    create_table :flags do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :restrict }, index: true
      t.text :name, null: false
      t.text :key, null: false
      t.text :description
      t.column :kind, :enum_flag_kinds, null: false
      t.timestamps
    end

    add_index :flags, [:organization_id, :key], unique: true
  end
end
