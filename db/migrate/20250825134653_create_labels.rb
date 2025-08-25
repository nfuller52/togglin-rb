class CreateLabels < ActiveRecord::Migration[8.0]
  def change
    create_table :labels do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade, index: true }
      t.text :name, null: false
      t.text :description
      t.text :color, null: false
      t.timestamps
    end

    add_index :labels, [:organization_id, :name], unique: true
  end
end
