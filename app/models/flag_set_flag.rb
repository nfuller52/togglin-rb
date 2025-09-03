# frozen_string_literal: true

# == Schema Information
#
# Table name: flag_set_flags
#
#  created_by_id :uuid             not null
#  flag_id       :uuid             not null, primary key
#  flag_set_id   :uuid             not null, primary key
#
# Indexes
#
#  index_flag_set_flags_on_flag_id      (flag_id)
#  index_flag_set_flags_on_flag_set_id  (flag_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id) ON DELETE => restrict
#  fk_rails_...  (flag_id => flags.id) ON DELETE => cascade
#  fk_rails_...  (flag_set_id => flag_sets.id) ON DELETE => cascade
#
class FlagSetFlag < ApplicationRecord
  belongs_to :flag
  belongs_to :flag_set
end
