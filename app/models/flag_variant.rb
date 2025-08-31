# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_variants
#
#  id         :uuid             not null, primary key
#  name       :text             not null
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  flag_id    :uuid             not null
#
# Indexes
#
#  index_flag_variants_on_flag_id           (flag_id)
#  index_flag_variants_on_flag_id_and_name  (flag_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (flag_id => flags.id) ON DELETE => cascade
#
class FlagVariant < ApplicationRecord
  belongs_to :flag
end
