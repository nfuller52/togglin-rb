class CreateApplicationSdkKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :application_sdk_keys do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.references :application, null: false, foreign_key: { on_delete: :cascade }
      t.references :environment, null: false, foreign_key: { on_delete: :restrict }
      t.text :key, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
