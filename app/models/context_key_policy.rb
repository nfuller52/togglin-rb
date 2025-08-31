# frozen_string_literal: true

# == Schema Information
#
# Table name: context_key_policies
#
#  id               :uuid             not null, primary key
#  algorithm        :text             default("sha256"), not null
#  is_deterministic :boolean          default(TRUE), not null
#  salt             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  organization_id  :uuid             not null
#
# Indexes
#
#  index_context_key_policies_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#
class ContextKeyPolicy < ApplicationRecord
  belongs_to :organization

  validates :algorithm, presence: true, inclusion: { in: %w[HMAC_SHA256 AES256] }
  validates :salt, presence: true
end
