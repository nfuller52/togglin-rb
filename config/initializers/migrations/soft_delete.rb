# frozen_string_literal: true

module Migrations
  module SoftDelete
    def soft_delete(to_table: :users, type: :uuid, null: true, index: false, on_delete: :restrict)
      column :deleted_at, :datetime, null: true

      references :deleted_by,
                 type: type,
                 null: null,
                 index: index,
                 foreign_key: { to_table: to_table, on_delete: on_delete }
    end
  end
end
