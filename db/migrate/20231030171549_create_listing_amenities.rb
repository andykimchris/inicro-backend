class CreateListingAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :listing_amenities do |t|
      t.boolean :onsite_parking
      t.boolean :gymnasium
      t.boolean :elevator
      t.boolean :security_cameras
      t.boolean :wheelchair_accessible
      t.boolean :generator
      t.boolean :borehole
      t.boolean :solar_panels
      t.boolean :swimming_pool
      t.boolean :rooftop
      t.boolean :salon
      t.boolean :mini_market
      t.text :metadata

      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
