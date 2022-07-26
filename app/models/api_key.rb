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
class ApiKey < ApplicationRecord
  before_create :generate_access_token

  def self.filter(params)
    scope = all
    scope = scope.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
    scope
  end

  private
    def generate_access_token
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists?(access_token:)
    end
end
