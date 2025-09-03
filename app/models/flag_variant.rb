# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_variants
#
#  id            :uuid             not null, primary key
#  deleted_at    :datetime
#  name          :text             not null
#  weight        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :uuid             not null
#  deleted_by_id :uuid
#  flag_id       :uuid             not null
#  updated_by_id :uuid             not null
#
# Indexes
#
#  index_flag_variants_on_flag_id           (flag_id)
#  index_flag_variants_on_flag_id_and_name  (flag_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (deleted_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (flag_id => flags.id) ON DELETE => cascade
#  fk_rails_...  (updated_by_id => users.id) ON DELETE => restrict
#
class FlagVariant < ApplicationRecord
  belongs_to :flag
end
