class ContextKind < ApplicationRecord
  belongs_to :organization
  has_many :context_schemas, dependent: :destroy
  has_many :segments, dependent: :restrict_with_exception

  before_validation :normalize_key

  validates :key, presence: true, uniqueness: { scope: :organization_id }, format: { with: /\A[a-z0-9:_-]+\z/ }
  validates :client_allowed, inclusion: { in: [true, false] }

  private

  def normalize_key
    self.key = key.to_s.strip.downcase
  end
end
