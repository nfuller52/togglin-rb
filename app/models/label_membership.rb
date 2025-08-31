# frozen_string_literal: true

# == Schema Information
#
# Table name: label_memberships
#
#  member_type :string           not null
#  label_id    :uuid             not null, primary key
#  member_id   :uuid             not null, primary key
#
# Indexes
#
#  idx_on_label_id_member_type_member_id_e286cff41a      (label_id,member_type,member_id) UNIQUE
#  index_label_memberships_on_label_id                   (label_id)
#  index_label_memberships_on_member                     (member_type,member_id)
#  index_label_memberships_on_member_type_and_member_id  (member_type,member_id)
#
# Foreign Keys
#
#  fk_rails_...  (label_id => labels.id) ON DELETE => cascade
#
class LabelMembership < ApplicationRecord
  belongs_to :label
  belongs_to :member, polymorphic: true

  validates :label_id, uniqueness: { scope: %i[member_type member_id] }

  validate :valid_organization_membership

  def valid_organization_membership
    return unless member.respond_to?(:organization_id)

    return unless member.organization_id != label.organization_id

    errors.add(:member, "must belong to the same organization as the label")
  end
end
