class ContextSchema < ApplicationRecord
  belongs_to :organization
  belongs_to :context_kind

  validates :spec, presence: true
  validates :version, numericality: { greater_than: 0}
end
