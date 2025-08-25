class CreateFlagVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :flag_variants do |t|
      t.references :flag, null: false, foreign_key: { on_delete: :cascade }, index: true
      t.text :name, null: false
      t.integer :weight
      t.timestamps
    end

    add_check_constraint :flag_variants, "weight IS NULL OR weight BETWEEN 0 AND 100000", name: "check_flag_variant_weight"
    add_index :flag_variants, [:flag_id, :name], unique: true
  end
end
