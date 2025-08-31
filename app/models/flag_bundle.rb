# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_bundles
#
#  id              :uuid             not null, primary key
#  bundle          :jsonb            not null
#  version         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  environment_id  :uuid             not null
#  flag_set_id     :uuid
#  organization_id :uuid             not null
#
# Indexes
#
#  idx_on_organization_id_environment_id_flag_set_id_v_8994316ef9  (organization_id,environment_id,flag_set_id,version DESC) UNIQUE
#  index_flag_bundles_on_environment_id                            (environment_id)
#  index_flag_bundles_on_flag_set_id                               (flag_set_id)
#  index_flag_bundles_on_organization_id                           (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (environment_id => environments.id) ON DELETE => restrict
#  fk_rails_...  (flag_set_id => flag_sets.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => restrict
#
class FlagBundle < ApplicationRecord
  belongs_to :organization
  belongs_to :environment
end
