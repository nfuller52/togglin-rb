# frozen_string_literal: true

class CreateEnvironments < ActiveRecord::Migration[8.0]
  def change
    create_table :environments, id: :uuid do |t|
      t.references :organization, type: :uuid, null: false,
                                  foreign_key: { on_delete: :restrict }, index: true
      t.text :name, null: false
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :environments, %i[organization_id name], unique: true
  end
end
