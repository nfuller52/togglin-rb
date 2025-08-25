class FlagBundle < ApplicationRecord
  belongs_to :organization
  belongs_to :environment
end
