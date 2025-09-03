# frozen_string_literal: true

# == Schema Information
#
# Table name: context_key_policies
#
#  id               :uuid             not null, primary key
#  algorithm        :text             default("sha256"), not null
#  deleted_at       :datetime
#  is_deterministic :boolean          default(TRUE), not null
#  salt             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  created_by_id    :uuid             not null
#  deleted_by_id    :uuid
#  organization_id  :uuid             not null
#  updated_by_id    :uuid             not null
#
# Indexes
#
#  index_context_key_policies_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class ContextKeyPolicy < ApplicationRecord
  belongs_to :organization

  validates :algorithm, presence: true, inclusion: { in: %w[HMAC_SHA256 AES256] }
  validates :salt, presence: true
end
