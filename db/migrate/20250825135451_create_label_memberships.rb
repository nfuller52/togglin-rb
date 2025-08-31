# frozen_string_literal: true

class CreateLabelMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :label_memberships, primary_key: %i[label_id member_id] do |t|
      t.references :label, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :member, type: :uuid, null: false, polymorphic: true
    end

    add_index :label_memberships, %i[member_type member_id]
    add_index :label_memberships, %i[label_id member_type member_id], unique: true
  end
end
