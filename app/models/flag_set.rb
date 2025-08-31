# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_sets
#
#  id              :uuid             not null, primary key
#  key             :text             not null
#  name            :text             not null
#  purpose         :enum             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :uuid             not null
#
# Indexes
#
#  index_flag_sets_on_organization_id          (organization_id)
#  index_flag_sets_on_organization_id_and_key  (organization_id,key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => restrict
#
class FlagSet < ApplicationRecord
  include Labelable

  belongs_to :organization
end
