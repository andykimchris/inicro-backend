class CreateUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :units do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :size
      t.integer :amount, null: false
      t.integer :unit_type, null: false
      t.integer :bedroom_count
      t.integer :bathroom_count
      t.integer :full_bathroom_count
      t.string :floorplan_image
      t.text :description
      t.string :identifier
      t.boolean :is_available
      t.datetime :availability_date

      t.timestamps
    end
  end
end
