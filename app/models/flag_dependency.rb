class FlagDependency < ApplicationRecord
  belongs_to :organization
  belongs_to :parent_flag_id
  belongs_to :child_flag_id
end
