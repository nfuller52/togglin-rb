# frozen_string_literal: true

module Migrations
  module SoftDelete
    def soft_delete
      column :deleted_at, :datetime, null: true
    end
  end
end
