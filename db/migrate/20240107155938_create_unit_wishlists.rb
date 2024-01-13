class CreateUnitWishlists < ActiveRecord::Migration[7.1]
  def change
    create_table :unit_wishlists do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :unit, null: false, foreign_key: true
      t.string :title
      t.datetime :saved_at

      t.timestamps
    end
  end
end
