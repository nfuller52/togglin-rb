class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :restrict }
      t.references :default_flag_set, null: false, foreign_key: { on_delete: :nullify, to_table: :flag_sets }
      t.text :name, null: false
      t.text :key, null: false
      t.text :description
      t.timestamps
    end

    add_index :applications, [:organization_id, :key], unique: true
  end
end
