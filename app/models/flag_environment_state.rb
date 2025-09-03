# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_environment_states
#
#  id                   :uuid             not null, primary key
#  default_variant_name :text
#  deleted_at           :datetime
#  is_enabled           :boolean          default(FALSE), not null
#  rule_plan            :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  created_by_id        :uuid             not null
#  deleted_by_id        :uuid
#  environment_id       :uuid             not null
#  flag_id              :uuid             not null
#  updated_by_id        :uuid             not null
#
# Indexes
#
#  index_flag_environment_states_on_environment_id              (environment_id)
#  index_flag_environment_states_on_flag_id                     (flag_id)
#  index_flag_environment_states_on_flag_id_and_environment_id  (flag_id,environment_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (environment_id => environments.id)
#  fk_rails_...  (flag_id => flags.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class FlagEnvironmentState < ApplicationRecord
  belongs_to :flag
  belongs_to :environment
end
