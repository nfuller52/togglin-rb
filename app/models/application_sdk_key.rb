# frozen_string_literal: true

# == Schema Information
#
# Table name: application_sdk_keys
#
#  id              :uuid             not null, primary key
#  is_active       :boolean          default(TRUE), not null
#  key             :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  application_id  :uuid             not null
#  created_by_id   :uuid             not null
#  deleted_by_id   :uuid
#  environment_id  :uuid             not null
#  organization_id :uuid             not null
#  updated_by_id   :uuid             not null
#
# Indexes
#
#  index_application_sdk_keys_on_application_id   (application_id)
#  index_application_sdk_keys_on_environment_id   (environment_id)
#  index_application_sdk_keys_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (application_id => applications.id) ON DELETE => cascade
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (environment_id => environments.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class ApplicationSdkKey < ApplicationRecord
  belongs_to :organization
  belongs_to :application
  belongs_to :environment
end
