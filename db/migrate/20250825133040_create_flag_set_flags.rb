# frozen_string_literal: true

class CreateFlagSetFlags < ActiveRecord::Migration[8.0]
  def change
    create_table :flag_set_flags, primary_key: %i[flag_id flag_set_id] do |t|
      t.references :flag, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :flag_set, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.trackables only: [:created_by]
    end
  end
end
