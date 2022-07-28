class CreateLanguageIndicators < ActiveRecord::Migration[7.0]
  def change
    create_table :language_indicators, id: :uuid do |t|
      t.uuid    :language_id
      t.string  :language_code
      t.string  :indicator_id
      t.string  :name
      t.string  :audio

      t.timestamps
    end
  end
end
