# frozen_string_literal: true

class CreateSegmentMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :segment_memberships, id: :uuid do |t|
      t.references :segment, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.text :stable_context_key, null: false
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_index :segment_memberships, %i[segment_id stable_context_key], unique: true
  end
end
