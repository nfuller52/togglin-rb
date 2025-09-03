# frozen_string_literal: true

class CreateApplicationSdkKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :application_sdk_keys, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :application, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :environment, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
      t.text :key, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
      t.trackables
    end
  end
end
