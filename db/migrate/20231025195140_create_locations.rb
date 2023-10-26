class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.float :latitude
      t.float :longitude
      t.string :address, null: false
      t.string :city, null: false
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :tags

      t.timestamps
    end
  end
end
