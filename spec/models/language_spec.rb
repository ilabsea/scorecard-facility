# == Schema Information
#
# Table name: languages
#
#  id         :uuid             not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Language, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
