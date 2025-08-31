# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations, id: :uuid do |t|
      t.text :name, null: false
      t.text :slug, null: false
      t.timestamps
    end

    add_index :organizations, :slug, unique: true
  end
end
