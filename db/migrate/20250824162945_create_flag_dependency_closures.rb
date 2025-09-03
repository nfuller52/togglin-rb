# frozen_string_literal: true

class CreateFlagDependencyClosures < ActiveRecord::Migration[8.0]
  def change
    create_table :flag_dependency_closures,
                 primary_key: %i[organization_id ancestor_flag_id descendant_flag_id] do |t|
      t.references :organization, type: :uuid, null: false, foreign_key: { on_delete: :cascade },
                                  index: true
      t.references :ancestor_flag, type: :uuid, null: false,
                                   foreign_key: { to_table: :flags, on_delete: :cascade },
                                   index: true
      t.references :descendant_flag, type: :uuid, null: false,
                                     foreign_key: { to_table: :flags, on_delete: :cascade },
                                     index: true
      t.integer :depth, null: false
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_check_constraint :flag_dependency_closures, 'depth >= 1',
                         name: 'check_flag_dependency_closure_depth'
    add_index :flag_dependency_closures, %i[descendant_flag_id ancestor_flag_id]
  end
end
