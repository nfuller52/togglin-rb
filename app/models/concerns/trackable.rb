# frozen_string_literal: true

module Trackable
  extend ActiveSupport::Concern

  included do
    belongs_to :created_by, class_name: "User", optional: true
    belongs_to :updated_by, class_name: "User", optional: true
    belongs_to :deleted_by, class_name: "User", optional: true

    before_validation :set_trackable_fields

    validates :created_by, presence: true
    validates :updated_by, presence: true
  end

  def set_trackable_fields
    if Current.user
      self.created_by_id ||= Current.user.id
      self.updated_by_id = Current.user.id
    end
  end
end
