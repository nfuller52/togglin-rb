# frozen_string_literal: true

# == Schema Information
#
# Table name: context_kinds
#
#  id                           :uuid             not null, primary key
#  description                  :text
#  is_allowed_in_client_bundles :boolean          default(TRUE), not null
#  key                          :text             not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  organization_id              :uuid             not null
#
# Indexes
#
#  index_context_kinds_on_organization_id          (organization_id)
#  index_context_kinds_on_organization_id_and_key  (organization_id,key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#
class ContextKind < ApplicationRecord
  belongs_to :organization
  has_many :context_schemas, dependent: :destroy
  has_many :segments, dependent: :restrict_with_exception

  before_validation :normalize_key

  validates :key, presence: true, uniqueness: { scope: :organization_id },
                  format: { with: /\A[a-z0-9:_-]+\z/ }
  validates :client_allowed, inclusion: { in: [true, false] }

  private

  def normalize_key
    self.key = key.to_s.strip.downcase
  end
end
