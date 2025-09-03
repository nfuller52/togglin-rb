# == Schema Information
#
# Table name: user_sessions
#
#  id            :uuid             not null, primary key
#  deleted_at    :datetime
#  ip_address    :text
#  user_agent    :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :uuid             not null
#  deleted_by_id :uuid
#  updated_by_id :uuid             not null
#  user_id       :uuid             not null
#
# Indexes
#
#  index_user_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (user_id => users.id)
#
class UserSession < ApplicationRecord
  belongs_to :user
end
