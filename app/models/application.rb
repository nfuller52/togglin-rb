# frozen_string_literal: true

# == Schema Information
#
# Table name: applications
#
#  id                  :uuid             not null, primary key
#  description         :text
#  key                 :text             not null
#  name                :text             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  default_flag_set_id :uuid             not null
#  organization_id     :uuid             not null
#
# Indexes
#
#  index_applications_on_default_flag_set_id      (default_flag_set_id)
#  index_applications_on_organization_id          (organization_id)
#  index_applications_on_organization_id_and_key  (organization_id,key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (default_flag_set_id => flag_sets.id) ON DELETE => nullify
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => restrict
#
class Application < ApplicationRecord
  include Labelable

  belongs_to :organization
  belongs_to :default_flag_set
end
