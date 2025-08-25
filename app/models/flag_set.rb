class FlagSet < ApplicationRecord
  include Labelable

  belongs_to :organization
end
