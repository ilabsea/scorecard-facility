class CreateIndicators < ActiveRecord::Migration[7.0]
  def change
    create_table :indicators, id: :string do |t|
      t.string :facility_id
      t.string :name
      t.string :type
      t.string :endpoint
      t.string :standard_indicator_id
      t.string :deleted_at

      t.timestamps
    end
  end
end
