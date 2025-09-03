# frozen_string_literal: true

# == Schema Information
#
# Table name: flags
#
#  id              :uuid             not null, primary key
#  deleted_at      :datetime
#  description     :text
#  key             :text             not null
#  kind            :enum             not null
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
#  index_flags_on_organization_id          (organization_id)
#  index_flags_on_organization_id_and_key  (organization_id,key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => restrict
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class Flag < ApplicationRecord
  include Labelable

  belongs_to :organization
end
