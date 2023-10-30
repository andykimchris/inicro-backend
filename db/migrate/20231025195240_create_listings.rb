class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :size
      t.text :metadata
      t.integer :floor_count
      t.string :site_link
      t.integer :listing_type, null: false, default: 0
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
