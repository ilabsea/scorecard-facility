class CreateFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :facilities, id: :string do |t|
      t.string  :name_en
      t.string  :name_km
      t.string  :abbr_en
      t.string  :abbr_km
      t.string  :parent_id
      t.integer :lft, null: false
      t.integer :rgt, null: false
      t.integer :depth, default: 0, null: false
      t.integer :children_count, default: 0, null: false
      t.string  :dataset
      t.boolean :default, default: false

      t.timestamps
    end
  end
end
