# frozen_string_literal: true

class CreateOrganizationMemberships < ActiveRecord::Migration[8.0]
  def change
    create_enum :enum_organization_membership_roles, %w[member owner]

    create_table :organization_memberships, primary_key: %i[organization_id user_id] do |t|
      t.references :organization, type: :uuid, null: false, index: true,
                                  foreign_key: { on_delete: :cascade }
      t.references :user,         type: :uuid, null: false, index: true,
                                  foreign_key: { on_delete: :cascade }

      t.enum :role, enum_type: :enum_organization_membership_roles, null: false, default: 'member'
      t.timestamps
      t.trackables only: [:created_by, :updated_by]
    end

    add_index :organization_memberships, %i[organization_id user_id], unique: true
  end
end
