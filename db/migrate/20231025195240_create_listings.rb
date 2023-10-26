class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.integer :size
      t.text :metadata
      t.integer :floor_count
      t.integer :type, null: false, default: 0
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
