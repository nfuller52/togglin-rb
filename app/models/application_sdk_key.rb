class ApplicationSdkKey < ApplicationRecord
  belongs_to :organization
  belongs_to :application
  belongs_to :environment
end
