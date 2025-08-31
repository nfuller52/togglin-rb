class CreateSegmentMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :segment_memberships do |t|
      t.references :segment, null: false, foreign_key: { on_delete: :cascade }
      t.text :stable_context_key, null: false
      t.timestamps
    end

    add_index :segment_memberships, [:segment_id, :stable_context_key], unique: true
  end
end
