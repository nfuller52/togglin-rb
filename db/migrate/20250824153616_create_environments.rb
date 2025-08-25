class CreateEnvironments < ActiveRecord::Migration[8.0]
  def change
    create_table :environments do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :restrict }, index: true
      t.text :name, null: false
      t.timestamps
    end

    add_index :environments, [:organization_id, :name], unique: true
  end
end
