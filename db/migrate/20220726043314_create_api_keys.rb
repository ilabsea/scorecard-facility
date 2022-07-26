class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys, id: :uuid do |t|
      t.string :name
      t.string :access_token

      t.timestamps
    end
  end
end
