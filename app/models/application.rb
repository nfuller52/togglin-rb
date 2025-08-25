class Application < ApplicationRecord
  include Labelable

  belongs_to :organization
  belongs_to :default_flag_set
end
