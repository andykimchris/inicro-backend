class CreateListingAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :listing_amenities do |t|
      t.string :title
      t.text :description
      t.boolean :is_available
      t.text :metadata
      t.integer :listing_type, null: false, default: 0
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
