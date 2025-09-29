# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id            :uuid             not null, primary key
#  deleted_at    :datetime
#  name          :text             not null
#  slug          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :uuid             not null
#  deleted_by_id :uuid
#  updated_by_id :uuid             not null
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class Organization < ApplicationRecord
  include Trackable

  SERIALIZER_PROFILES = {
    default: %i[id name slug created_at updated_at]
  }

  SLUG_REGEX = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships

  validates :name, presence: true, length: { maximum: 200 }
  validates :slug,
            presence: true,
            length: { maximum: 100 },
            format: { with: SLUG_REGEX, message: "must be lowercase letters, numbers, and hyphens" },
            uniqueness: { case_sensitive: false }

  class << self
    def onboard(name:, owner:)
      transaction do
        org = new({ name: name, slug: name.parameterize })

        if org.save
          org.organization_memberships.create({ user: owner, role: :owner })
        end

        org
      end
    end
  end
end
