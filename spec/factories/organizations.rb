# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "Organization #{n}" }
    sequence(:slug) { |n| "organization-#{n}" }
    association :created_by, factory: :user
    association :updated_by, factory: :user
  end
end
