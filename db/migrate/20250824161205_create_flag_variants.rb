# frozen_string_literal: true

class CreateFlagVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :flag_variants, id: :uuid do |t|
      t.references :flag, type: :uuid, null: false, foreign_key: { on_delete: :cascade },
                          index: true
      t.text :name, null: false
      t.integer :weight
      t.timestamps
      t.trackables
      t.soft_delete
    end

    add_check_constraint :flag_variants, 'weight IS NULL OR weight BETWEEN 0 AND 100000',
                         name: 'check_flag_variant_weight'
    add_index :flag_variants, %i[flag_id name], unique: true
  end
end
