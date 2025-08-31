# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_dependency_closures
#
#  depth              :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  ancestor_flag_id   :uuid             not null, primary key
#  descendant_flag_id :uuid             not null, primary key
#  organization_id    :uuid             not null, primary key
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
#  fk_rails_...  (descendant_flag_id => flags.id) ON DELETE => cascade
#  fk_rails_...  (organization_id => organizations.id) ON DELETE => cascade
#
class FlagDependencyClosure < ApplicationRecord
  belongs_to :organization
  belongs_to :ancestor_flag
  belongs_to :descendant_flag
end
