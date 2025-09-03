# frozen_string_literal: true

module Migrations
  module Trackables
    def trackables(to_table: :users,
                   type: :uuid,
                   null: false,
                   index: false,
                   on_delete: :restrict,
                   only: [:created_by, :updated_by])
      if only.include?(:created_by)
        references :created_by,
                   type: type,
                   null: null,
                   index: index,
                   foreign_key: { to_table: to_table, on_delete: on_delete }
      end

      if only.include?(:updated_by)
        references :updated_by,
                   type: type,
                   null: null,
                   index: index,
                   foreign_key: { to_table: to_table, on_delete: on_delete }
      end
    end
  end
end
