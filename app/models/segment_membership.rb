class SegmentMembership < ApplicationRecord
  self.primary_key = nil

  belongs_to :segment

  validates :stable_context_key, presence: true
end
