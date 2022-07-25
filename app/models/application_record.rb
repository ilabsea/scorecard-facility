class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private
    def secure_id
      self.id ||= SecureRandom.uuid[0..5]

      return unless self.class.exists?(id:)

      self.id = SecureRandom.uuid[0..5]
      secure_id
    end
end
