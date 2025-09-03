# frozen_string_literal: true

ActiveSupport.on_load :active_record do
  ActiveRecord::ConnectionAdapters::TableDefinition.include(Migrations::Trackables)
  ActiveRecord::ConnectionAdapters::TableDefinition.include(Migrations::SoftDelete)
  ActiveRecord::ConnectionAdapters::Table.include(Migrations::Trackables)
  ActiveRecord::ConnectionAdapters::Table.include(Migrations::SoftDelete)
end
