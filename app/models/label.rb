class Label < ApplicationRecord
  belongs_to :organization

  has_many :label_memberships, as: :member, dependent: :destroy
  has_many :members, through: :label_memberships, source: :member

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :color, presence: true, format: { with: /\A#(?:\h{3}|\h{6})\z/, message: "must be a valid hex color code" }
end
