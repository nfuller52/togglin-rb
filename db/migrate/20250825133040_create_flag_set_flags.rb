class CreateFlagSetFlags < ActiveRecord::Migration[8.0]
  def change
    create_table :flag_set_flags, primary_key: [:flag_id, :flag_set_id] do |t|
      t.references :flag, null: false, foreign_key: { on_delete: :cascade }
      t.references :flag_set, null: false, foreign_key: { on_delete: :cascade }
    end
  end
end
