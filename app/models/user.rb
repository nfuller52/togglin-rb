# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  confirmation_sent_at   :datetime
#  confirmed_at           :datetime
#  deleted_at             :datetime
#  email                  :citext           not null
#  password_digest        :text             not null
#  reset_password_sent_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  deleted_by_id          :uuid
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#
class User < ApplicationRecord
  include SoftDeletable

  SERIALIZER_PROFILES = {
    default: %i[id email created_at updated_at]
  }.freeze

  has_secure_password

  has_many :organization_memberships, dependent: :destroy
  has_many :organizations, through: :organization_memberships
  has_many :user_sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
end
