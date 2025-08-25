class CreateLabelMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :label_memberships, primary_key: [:label_id, :member_id] do |t|
      t.references :label, null: false, foreign_key: { on_delete: :cascade }
      t.references :member, null: false, polymorphic: true
    end

    add_index :label_memberships, [:member_type, :member_id]
    add_index :label_memberships, [:label_id, :member_type, :member_id], unique: true
  end
end
