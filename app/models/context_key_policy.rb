class ContextKeyPolicy < ApplicationRecord
  belongs_to :organization

  validates :algorithm, presence: true, inclusion: { in: ['HMAC_SHA256', 'AES256'] }
  validates :salt, presence: true
end
