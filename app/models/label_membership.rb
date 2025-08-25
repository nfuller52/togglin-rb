class LabelMembership < ApplicationRecord
  belongs_to :label
  belongs_to :member, polymorphic: true

  validates :label_id, uniqueness: { scope: [:member_type, :member_id] }

  validate :valid_organization_membership

  def valid_organization_membership
    return unless member.respond_to?(:organization_id)

    if member.organization_id != label.organization_id
      errors.add(:member, "must belong to the same organization as the label")
    end
  end
end
