# frozen_string_literal: true

class CreateFlagBundles < ActiveRecord::Migration[8.0]
  def change
    create_table :flag_bundles, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false,
                                  foreign_key: { on_delete: :restrict },
                                  index: true
      t.references :environment, type: :uuid, null: false,
        foreign_key: { on_delete: :restrict },
                                 index: true
      t.references :flag_set, type: :uuid, null: true,
      foreign_key: { on_delete: :restrict },
                              index: true
      t.integer :version, null: false
      t.jsonb :bundle, null: false
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :flag_bundles, 'organization_id, environment_id, flag_set_id, version DESC',
              unique: true
  end
end
