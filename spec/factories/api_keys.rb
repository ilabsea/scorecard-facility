# == Schema Information
#
# Table name: api_keys
#
#  id           :uuid             not null, primary key
#  name         :string
#  access_token :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :api_key do
    name { FFaker::Name.name }
  end
end
