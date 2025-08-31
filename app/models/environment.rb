# frozen_string_literal: true

# == Schema Information
#
# Table name: environments
#
#  id              :uuid             not null, primary key
#  name            :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :uuid             not null
#
# Indexes
#
#  index_environments_on_organization_id           (organization_id)
#  index_environments_on_organization_id_and_name  (organization_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => restrict
#
class Environment < ApplicationRecord
  belongs_to :organization
end
