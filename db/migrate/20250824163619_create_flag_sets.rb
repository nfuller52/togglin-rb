class CreateFlagSets < ActiveRecord::Migration[8.0]
  def change
    create_enum :enum_flag_set_purpose, ["runtime", "build", "test"]

    create_table :flag_sets do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :restrict }
      t.text :name, null: false
      t.text :key, null: false
      t.column :purpose, :enum_flag_set_purpose, null: false
      t.timestamps
    end

    add_index :flag_sets, [:organization_id, :key], unique: true
  end
end
