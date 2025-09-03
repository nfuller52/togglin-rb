# frozen_string_literal: true

class CreateFlags < ActiveRecord::Migration[8.0]
  def change
    create_enum :enum_flag_kinds, %w[boolean multivariate]

    create_table :flags, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false,
                                  foreign_key: { on_delete: :restrict }, index: true
      t.text :name, null: false
      t.text :key, null: false
      t.text :description
      t.column :kind, :enum_flag_kinds, null: false
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :flags, %i[organization_id key], unique: true
  end
end
