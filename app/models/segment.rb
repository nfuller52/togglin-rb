# frozen_string_literal: true

# == Schema Information
#
# Table name: segments
#
#  id              :uuid             not null, primary key
#  deleted_at      :datetime
#  key             :text             not null
#  name            :text             not null
#  rule            :jsonb            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  context_kind_id :uuid             not null
#  created_by_id   :uuid             not null
#  deleted_by_id   :uuid
#  organization_id :uuid             not null
#  updated_by_id   :uuid             not null
#
# Indexes
#
#  index_segments_on_context_kind_id          (context_kind_id)
#  index_segments_on_organization_id          (organization_id)
#  index_segments_on_organization_id_and_key  (organization_id,key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (context_kind_id => context_kinds.id) ON DELETE => restrict
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class Segment < ApplicationRecord
  belongs_to :organization
  belongs_to :context_kind
  has_many :segment_memberships, dependent: :delete_all

  validates :key, presence: true, uniqueness: { scope: :organization_id }
  validates :rule, presence: true

  def to_bundle_hash
    { key:, kind: context_kind.key, rule: }
  end
end
