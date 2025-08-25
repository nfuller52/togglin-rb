class FlagDependencyClosure < ApplicationRecord
  belongs_to :organization
  belongs_to :ancestor_flag
  belongs_to :descendant_flag
end
