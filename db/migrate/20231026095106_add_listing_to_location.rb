class AddListingToLocation < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :listing, null: false, foreign_key: true
  end
end
