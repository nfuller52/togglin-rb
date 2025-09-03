# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
      t.references :default_flag_set, type: :uuid, null: false,
                                      foreign_key: { on_delete: :nullify, to_table: :flag_sets }
      t.text :name, null: false
      t.text :key, null: false
      t.text :description
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :applications, %i[organization_id key], unique: true
  end
end
