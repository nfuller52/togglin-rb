# == Schema Information
#
# Table name: tokens
#
#  id              :uuid             not null, primary key
#  expires_at      :datetime
#  kind            :enum             not null
#  last_used_at    :datetime
#  max_uses        :integer          default(1), not null
#  resource_type   :string           not null
#  token_digest    :text             not null
#  token_prefix    :text             not null
#  use_count       :integer          default(0), not null
#  used_at         :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by_id   :uuid
#  deleted_by_id   :uuid
#  resource_id     :uuid             not null
#  rotated_from_id :uuid             not null
#  updated_by_id   :uuid
#
# Indexes
#
#  index_tokens_on_resource                                (resource_type,resource_id)
#  index_tokens_on_resource_type_and_resource_id_and_kind  (resource_type,resource_id,kind)
#  index_tokens_on_rotated_from_id                         (rotated_from_id)
#  index_tokens_on_token_digest                            (token_digest) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => cascade
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => cascade
#  fk_rails_...  (rotated_from_id => tokens.id)
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => cascade
#
class Token < ApplicationRecord
  belongs_to :rotated_from
end
