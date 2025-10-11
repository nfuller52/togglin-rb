# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  confirmation_sent_at   :datetime
#  confirmed_at           :datetime
#  deleted_at             :datetime
#  email                  :citext           not null
#  password_digest        :text             not null
#  reset_password_sent_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  deleted_by_id          :uuid
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'Password1!' }
  end
end
