# frozen_string_literal: true

# == Schema Information
#
# Table name: organization_memberships
#
#  role            :enum             default("member"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by_id   :uuid             not null
#  organization_id :uuid             not null, primary key
#  updated_by_id   :uuid             not null
#  user_id         :uuid             not null, primary key
#
# Indexes
#
#  index_organization_memberships_on_organization_id              (organization_id)
#  index_organization_memberships_on_organization_id_and_user_id  (organization_id,user_id) UNIQUE
#  index_organization_memberships_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class OrganizationMembership < ApplicationRecord
  include Trackable

  belongs_to :organization
  belongs_to :user
end
