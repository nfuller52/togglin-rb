# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_dependency_closures
#
#  deleted_at         :datetime
#  depth              :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  ancestor_flag_id   :uuid             not null, primary key
#  created_by_id      :uuid             not null
#  deleted_by_id      :uuid
#  descendant_flag_id :uuid             not null, primary key
#  organization_id    :uuid             not null, primary key
#  updated_by_id      :uuid             not null
#
# Indexes
#
#  idx_on_descendant_flag_id_ancestor_flag_id_3928a71b9f  (descendant_flag_id,ancestor_flag_id)
#  index_flag_dependency_closures_on_ancestor_flag_id     (ancestor_flag_id)
#  index_flag_dependency_closures_on_descendant_flag_id   (descendant_flag_id)
#  index_flag_dependency_closures_on_organization_id      (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (ancestor_flag_id => flags.id) ON DELETE => cascade
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (descendant_flag_id => flags.id) ON DELETE => cascade
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class FlagDependencyClosure < ApplicationRecord
  belongs_to :organization
  belongs_to :ancestor_flag
  belongs_to :descendant_flag
end
