class FlagEnvironmentState < ApplicationRecord
  belongs_to :flag
  belongs_to :environment
end
