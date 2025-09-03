# frozen_string_literal: true

class CreateFlagSets < ActiveRecord::Migration[8.0]
  def change
    create_enum :enum_flag_set_purpose, %w[runtime build test]

    create_table :flag_sets, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
      t.text :name, null: false
      t.text :key, null: false
      t.column :purpose, :enum_flag_set_purpose, null: false
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :flag_sets, %i[organization_id key], unique: true
  end
end
