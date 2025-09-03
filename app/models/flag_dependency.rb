# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_dependencies
#
#  deleted_at      :datetime
#  edge_kind       :enum             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  child_flag_id   :uuid             not null, primary key
#  created_by_id   :uuid             not null
#  deleted_by_id   :uuid
#  organization_id :uuid             not null, primary key
#  parent_flag_id  :uuid             not null, primary key
#  updated_by_id   :uuid             not null
#
# Indexes
#
#  index_flag_dependencies_on_child_flag_id    (child_flag_id)
#  index_flag_dependencies_on_organization_id  (organization_id)
#  index_flag_dependencies_on_parent_flag_id   (parent_flag_id)
#
# Foreign Keys
#
#  fk_rails_...  (child_flag_id => flags.id) ON DELETE => cascade
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#  fk_rails_...  (parent_flag_id => flags.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class FlagDependency < ApplicationRecord
  belongs_to :organization
  belongs_to :parent_flag_id
  belongs_to :child_flag_id
end
