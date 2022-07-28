# == Schema Information
#
# Table name: language_indicators
#
#  id            :uuid             not null, primary key
#  language_id   :uuid
#  language_code :string
#  indicator_id  :string
#  name          :string
#  audio         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe LanguageIndicator, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
