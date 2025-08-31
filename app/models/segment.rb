class Segment < ApplicationRecord
  belongs_to :organization
  belongs_to :context_kind
  has_many :segment_memberships, dependent: :delete_all

  validates :key, presence: true, uniqueness: { scope: :organization_id }
  validates :rule, presence: true

  def to_bundle_hash
    { key:, kind: context_kind.key, rule:}
  end
end
