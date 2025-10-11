# frozen_string_literal: true

# == Schema Information
#
# Table name: labels
#
#  id              :uuid             not null, primary key
#  color           :text             not null
#  description     :text
#  name            :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by_id   :uuid             not null
#  deleted_by_id   :uuid
#  organization_id :uuid             not null
#  updated_by_id   :uuid             not null
#
# Indexes
#
#  index_labels_on_organization_id           (organization_id)
#  index_labels_on_organization_id_and_name  (organization_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class Label < ApplicationRecord
  belongs_to :organization

  has_many :label_memberships, as: :member, dependent: :destroy
  has_many :members, through: :label_memberships, source: :member

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :color, presence: true,
                    format: {
                      with: /\A#(?:\h{3}|\h{6})\z/,
                      message: 'must be a valid hex color code'
                    }
end
