# frozen_string_literal: true

# == Schema Information
#
# Table name: segment_memberships
#
#  id                 :uuid             not null
#  stable_context_key :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  segment_id         :uuid             not null
#
# Indexes
#
#  index_segment_memberships_on_segment_id                         (segment_id)
#  index_segment_memberships_on_segment_id_and_stable_context_key  (segment_id,stable_context_key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (segment_id => segments.id) ON DELETE => cascade
#
class SegmentMembership < ApplicationRecord
  self.primary_key = nil

  belongs_to :segment

  validates :stable_context_key, presence: true
end
