module Labelable
  extend ActiveSupport::Concern

  included do
    has_many :label_memberships, as: :member, dependent: :destroy
    has_many :labels, through: :label_memberships, source: :label
  end
end
