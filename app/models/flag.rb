class Flag < ApplicationRecord
  include Labelable

  belongs_to :organization
end
