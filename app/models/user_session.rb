# frozen_string_literal: true

# == Schema Information
#
# Table name: user_sessions
#
#  id         :uuid             not null, primary key
#  ip_address :text
#  user_agent :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_user_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserSession < ApplicationRecord
  SERIALIZER_PROFILES = {
    default: %i[id]
  }.freeze

  belongs_to :user
  has_many :organizations, through: :user
end
