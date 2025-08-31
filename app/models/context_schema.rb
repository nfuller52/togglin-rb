# frozen_string_literal: true

# == Schema Information
#
# Table name: context_schemas
#
#  id              :uuid             not null, primary key
#  spec            :jsonb
#  version         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  context_kind_id :uuid             not null
#  organization_id :uuid             not null
#
# Indexes
#
#  idx_on_organization_id_context_kind_id_version_b7c80e9551  (organization_id,context_kind_id,version) UNIQUE
#  index_context_schemas_on_context_kind_id                   (context_kind_id)
#  index_context_schemas_on_organization_id                   (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (context_kind_id => context_kinds.id) ON DELETE => cascade
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#
class ContextSchema < ApplicationRecord
  belongs_to :organization
  belongs_to :context_kind

  validates :spec, presence: true
  validates :version, numericality: { greater_than: 0 }
end
