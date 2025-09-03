# frozen_string_literal: true

# == Schema Information
#
# Table name: applications
#
#  id                  :uuid             not null, primary key
#  deleted_at          :datetime
#  description         :text
#  key                 :text             not null
#  name                :text             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  created_by_id       :uuid             not null
#  default_flag_set_id :uuid             not null
#  deleted_by_id       :uuid
#  organization_id     :uuid             not null
#  updated_by_id       :uuid             not null
#
# Indexes
#
#  index_applications_on_default_flag_set_id      (default_flag_set_id)
#  index_applications_on_organization_id          (organization_id)
#  index_applications_on_organization_id_and_key  (organization_id,key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (default_flag_set_id => flag_sets.id) ON DELETE => nullify
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => restrict
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class Application < ApplicationRecord
  include Labelable

  belongs_to :organization
  belongs_to :default_flag_set
end
